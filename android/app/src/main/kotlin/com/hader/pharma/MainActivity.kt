package com.hader.pharma

import com.dantsu.escposprinter.EscPosPrinter
import com.dantsu.escposprinter.EscPosCharsetEncoding
import com.dantsu.escposprinter.connection.bluetooth.BluetoothPrintersConnections
import java.nio.charset.Charset
import android.bluetooth.*
import android.content.*
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import java.io.ByteArrayOutputStream

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
                    "sendData" -> {
    val address = call.argument<String>("address")
    val bytes =  call.argument<List<Int>>("data")

    if (address == null || bytes == null) {
        result.error("INVALID", "Address or data missing", null)
        return@setMethodCallHandler
    }

    val success = sendDataToPairedDevice(address, bytes)
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
    data: List<Int>
): Boolean {

     val connection = BluetoothPrintersConnections()
            .getList()
            ?.firstOrNull { it.device.address == deviceAddress }
            ?: return false

   val printerInstance: EscPosPrinter= EscPosPrinter(
       connection,
        203,
        80f,
        48,
        EscPosCharsetEncoding(
            "PC437",
            0
        )
    )
    printerInstance.useEscAsteriskCommand(true)
    printerInstance.printFormattedText( """
[C]<b>Hello, Printer!</b>
[L]<u>Underlined Text</u>
[L]Normal line 4
[L]Normal line 5
[L]Normal line 6
[L]Normal line 7
[L]Normal line 8


""".trimIndent()
    )
    return true
}
// private fun sendDataToPairedDevice(
//     deviceAddress: String,
//     data: List<Int>
// ): Boolean {

//     if (bluetoothAdapter == null || !bluetoothAdapter.isEnabled) {
//         return false
//     }

//     val device: BluetoothDevice =
//         bluetoothAdapter.getRemoteDevice(deviceAddress)

//     val uuid: UUID =
//         device.uuids?.firstOrNull()?.uuid
//             ?: UUID.fromString("00001101-0000-1000-8000-00805F9B34FB")

//     var socket: BluetoothSocket? = null

//     return try {
//         socket = device.createRfcommSocketToServiceRecord(uuid)
//         bluetoothAdapter.cancelDiscovery()
//         socket.connect()

//         val outputStream = socket.outputStream

//         // // ✅ CRITICAL FIX: convert List<Int> → ByteArray
//         // val byteArray = ByteArray(data.size)
//         // for (i in data.indices) {
//         //     byteArray[i] = data[i].toByte()
//         // }

//         outputStream.write(generateTestTicketImage())
//         outputStream.flush()

//         true
//     } catch (e: Exception) {
//         e.printStackTrace()
//         false
//     } finally {
//         try {
//             socket?.close()
//         } catch (_: Exception) {}
//     }
// }

// fun generateTestTicketImage(): ByteArray {
//     // Create a bitmap (width depends on printer, e.g., 384 pixels for 80mm paper)
//     val width = 384
//     val lineHeight = 40
//     val lines = 8 // number of lines
//     val height = lineHeight * lines
//     val bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)

//     // Draw on the bitmap
//     val canvas = Canvas(bitmap)
//     canvas.drawColor(Color.WHITE) // background white

//     val paint = Paint().apply {
//         color = Color.BLACK
//         textSize = 32f
//         isAntiAlias = true
//     }

//     var y = lineHeight.toFloat()

//     canvas.drawText("Hello, Printer!", 0f, y, paint)
//     y += lineHeight
//     paint.isFakeBoldText = true
//     canvas.drawText("Bold Text", 0f, y, paint)
//     paint.isFakeBoldText = false
//     y += lineHeight
//     paint.isUnderlineText = true
//     canvas.drawText("Underlined Text", 0f, y, paint)
//     paint.isUnderlineText = false
//     y += lineHeight
//     canvas.drawText("Normal line 4", 0f, y, paint)
//     y += lineHeight
//     canvas.drawText("Normal line 5", 0f, y, paint)
//     y += lineHeight
//     canvas.drawText("Normal line 6", 0f, y, paint)
//     y += lineHeight
//     canvas.drawText("Normal line 7", 0f, y, paint)
//     y += lineHeight
//     canvas.drawText("Normal line 8", 0f, y, paint)

//     // Convert bitmap to byte array (PNG)
//     val stream = ByteArrayOutputStream()
//     bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
//     return stream.toByteArray()
// }





    override fun onDestroy() {
        super.onDestroy()
        try {
            unregisterReceiver(receiver)
        } catch (_: Exception) {
        }
    }
}
