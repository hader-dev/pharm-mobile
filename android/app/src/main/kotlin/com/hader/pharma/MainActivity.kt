package com.hader.pharma

import java.nio.charset.Charset
import android.bluetooth.*
import android.content.*
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*
import android.graphics.BitmapFactory
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import java.io.ByteArrayOutputStream
import android.bluetooth.BluetoothSocket
import android.util.Base64
import android.util.Log
import java.io.IOException
import java.io.OutputStream


class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.hader.pharma/blueTooth"
    private val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()

    private val discoveredDevices = mutableMapOf<String, Map<String, Any?>>()

    private val receiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            when (intent?.action) {
                BluetoothDevice.ACTION_FOUND -> {
                    val device =
                        intent.getParcelableExtra<BluetoothDevice>(BluetoothDevice.EXTRA_DEVICE)

                    device?.let {
                        discoveredDevices[it.address] = deviceToMap(it)
                    }
                }
            }
        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {

                    "scanDevices" -> {
                        startDiscovery()
                        result.success(null)
                    }
                    "stopScan" -> {
                        bluetoothAdapter?.cancelDiscovery()
                        result.success(null)
                    }

                    "getDevices" -> {
                        result.success(discoveredDevices.values.toList())
                    }
                    "getBoundedDevices" -> {
                        result.success(getBondedBluetoothDevices())
                    }
//                     "sendData" -> {
//     val address = call.argument<String>("address")
//     val bytes =  call.argument<ByteArray>("data")

//     if (address == null || bytes == null) {
//         result.error("INVALID", "Address or data missing", null)
//         return@setMethodCallHandler
//     }

//     val success = sendDataToPairedDevice(address, bytes)
//     result.success(success)
// }
                    "sendBitMapData" -> {
    val address = call.argument<String>("address")
    val bytes =  call.argument<ByteArray>("data")

    if (address == null || bytes == null) {
        result.error("INVALID", "Address or data missing", null)
        return@setMethodCallHandler
    }
    val bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)

val scaledBitmap = Bitmap.createScaledBitmap(bitmap, 384, 200, false)
    
    val success = sendDataToPairedDevice(address, scaledBitmap)
    result.success(success)
}



                    else -> result.notImplemented()
                }
            }
    }

    private fun startDiscovery() {
        discoveredDevices.clear()

        bluetoothAdapter?.let { adapter ->
            if (adapter.isDiscovering) {
                adapter.cancelDiscovery()
            }

            val filter = IntentFilter(BluetoothDevice.ACTION_FOUND)
            registerReceiver(receiver, filter)

            adapter.startDiscovery()
        }
    }

    private fun deviceToMap(device: BluetoothDevice): Map<String, Any?> {
        return mapOf(
            "name" to device.name,
            "address" to device.address,
            "bondState" to bondStateToString(device.bondState),
            "type" to deviceTypeToString(device.type),
            "uuids" to device.uuids?.map { it.uuid.toString() },
            "bluetoothClass" to device.bluetoothClass?.deviceClass,
            "majorDeviceClass" to device.bluetoothClass?.majorDeviceClass,
            "isConnected" to isConnected(device)
        )
    }

    private fun bondStateToString(state: Int): String =
        when (state) {
            BluetoothDevice.BOND_BONDED -> "bonded"
            BluetoothDevice.BOND_BONDING -> "bonding"
            else -> "none"
        }

    private fun deviceTypeToString(type: Int): String =
        when (type) {
            BluetoothDevice.DEVICE_TYPE_CLASSIC -> "classic"
            BluetoothDevice.DEVICE_TYPE_LE -> "ble"
            BluetoothDevice.DEVICE_TYPE_DUAL -> "dual"
            else -> "unknown"
        }

    private fun isConnected(device: BluetoothDevice): Boolean {
        return try {
            val method = device.javaClass.getMethod("isConnected")
            method.invoke(device) as Boolean
        } catch (e: Exception) {
            false
        }
    }

    fun getBondedBluetoothDevices(): List<Map<String, Any?>> {
    
    if (bluetoothAdapter == null || !bluetoothAdapter.isEnabled) {
        // Bluetooth is not supported or not enabled
        return emptyList()
    }

    val bondedDevices: Set<BluetoothDevice> = bluetoothAdapter.bondedDevices
  return bondedDevices.map { deviceToMap(it) }
}



private fun sendDataToPairedDevice(
    deviceAddress: String,
    img: Bitmap
): Boolean {

    if (bluetoothAdapter == null || !bluetoothAdapter.isEnabled) {
        return false
    }

    val device: BluetoothDevice =
        bluetoothAdapter.getRemoteDevice(deviceAddress)

    val uuid: UUID =
        device.uuids?.firstOrNull()?.uuid
            ?: UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")

    var socket: BluetoothSocket? = null
  
    return try {

        socket = device.createInsecureRfcommSocketToServiceRecord(uuid)

        bluetoothAdapter.cancelDiscovery()
        socket.connect()
        val printerWidth = 576 // 80mm printer width
val scaledHeight = img.height * printerWidth / img.width
val scaledBitmap = Bitmap.createScaledBitmap(img, printerWidth, scaledHeight, true)
printImageBase64(scaledBitmap, scaledBitmap.width, scaledBitmap.height, socket)
//         val text = "Hello Thermal Printer\nHello Thermal Printer\nHello Thermal Printer\nHello Thermal Printer\nHello Thermal Printer\nHello Thermal Printer\n"

// // Convert text to bytes and then to Base64
//         val rawBase64Data = Base64.encodeToString(text.toByteArray(Charset.forName("ISO-8859-1")), Base64.DEFAULT)
//         printRawData(rawBase64Data, socket)


        // val outputStream = socket.outputStream

        // outputStream.write(text.toByteArray(Charset.forName("windows-1256")))
        // outputStream.flush()
       
        true
    } catch (e: Exception) {
        e.printStackTrace()
        false
    } finally {
        try {
         //   socket?.close()
        } catch (_: Exception) {}
    }
}



fun printRawData(
    rawBase64Data: String,
    mBluetoothSocket: BluetoothSocket?,
    
) {
    synchronized(this) {
        if (mBluetoothSocket == null || !mBluetoothSocket.isConnected) {
            throw Exception("bluetooth connection is not built, may be you forgot to connectPrinter")
            return
        }

        val socket = mBluetoothSocket
        Log.v("Printer", "start to print raw data $rawBase64Data")

        Thread {
            val bytes = Base64.decode(rawBase64Data, Base64.DEFAULT)
            var printerOutputStream: OutputStream? = null

            // Double-check the connection in the thread
            synchronized(this) {
                if (socket == null || !socket.isConnected) {
                    Log.e("Printer", "Socket disconnected during printing")
                    return@Thread
                }
                try {
                    printerOutputStream = socket.outputStream
                } catch (e: IOException) {
                    Log.e("Printer", "Failed to get output stream: ${e.message}")
                    return@Thread
                }
            }

            // Write the data safely
            printerOutputStream?.let { output ->
                try {
                    output.write(bytes, 0, bytes.size)
                    output.flush()
                    Log.v("Printer", "Successfully printed raw data")
                } catch (e: IOException) {
                    Log.e("Printer", "Failed to print data: ${e.message}")
                    e.printStackTrace()
                }
            }

            socket.close()

        }.start()

    }
}



fun printImageBase64(
    bitmapImage: Bitmap?,
    imageWidth: Int,
    imageHeight: Int,
    mBluetoothSocket: BluetoothSocket?,
    
) {
    val SET_LINE_SPACE_24 = byteArrayOf(0x1B, 0x33, 24)
val SET_LINE_SPACE_32 = byteArrayOf(0x1B, 0x33, 32)
val CENTER_ALIGN = byteArrayOf(0x1B, 0x61, 1)
val SELECT_BIT_IMAGE_MODE = byteArrayOf(0x1B, 0x2A, 33)
val LINE_FEED = byteArrayOf(0x0A)

    if (bitmapImage == null) {
        throw Exception("image not found")
        return
    }

    if (mBluetoothSocket == null) {
        throw Exception("bluetooth connection is not built, may be you forgot to connectPrinter")
        return
    }

    try {
        val pixels: Array<IntArray> = getPixelsSlow(bitmapImage, imageWidth, imageHeight)
        val outputStream: OutputStream = mBluetoothSocket.outputStream

        // ESC/POS commands
        outputStream.write(SET_LINE_SPACE_24)
        outputStream.write(CENTER_ALIGN)

        var y = 0
        while (y < pixels.size) {
            outputStream.write(SELECT_BIT_IMAGE_MODE)

            val nL = (pixels[y].size and 0xFF).toByte()
            val nH = ((pixels[y].size shr 8) and 0xFF).toByte()
            outputStream.write(byteArrayOf(nL, nH))

            for (x in pixels[y].indices) {
                outputStream.write(recollectSlice(y, x, pixels))
            }

            
            y += 24
        }

        outputStream.write(SET_LINE_SPACE_32)
        outputStream.write(LINE_FEED)
outputStream.write(LINE_FEED)
outputStream.write(LINE_FEED)
        outputStream.write(LINE_FEED)

        outputStream.flush()
    } catch (e: IOException) {
        Log.e("Printer", "failed to print data", e)
        e.printStackTrace()
    }
}


// Helper function: convert Bitmap to pixel array
fun getPixelsSlow(bitmap: Bitmap, width: Int, height: Int): Array<IntArray> {
    val scaledBitmap = Bitmap.createScaledBitmap(bitmap, width, height, false)
    val pixels = Array(scaledBitmap.height) { IntArray(scaledBitmap.width) }
    for (y in 0 until scaledBitmap.height) {
        for (x in 0 until scaledBitmap.width) {
            val pixel = scaledBitmap.getPixel(x, y)
            pixels[y][x] = if ((pixel and 0xFF) < 128) 1 else 0
        }
    }
    return pixels
}

// Helper function: slice 24 vertical pixels into 3 bytes
fun recollectSlice(y: Int, x: Int, pixels: Array<IntArray>): ByteArray {
    val slice = ByteArray(3)

    for (k in 0..2) {
        var sliceByte = 0
        for (b in 0..7) {
            val yPos = y + k * 8 + b
            if (yPos < pixels.size) {
                // Convert to Int, shift, or, then mask to Byte
                sliceByte = sliceByte or (pixels[yPos][x] shl (7 - b))
            }
        }
        slice[k] = sliceByte.toByte()  // convert Int to Byte
    }

    return slice
}









    override fun onDestroy() {
        super.onDestroy()
        try {
            unregisterReceiver(receiver)
        } catch (_: Exception) {
        }
    }
}
