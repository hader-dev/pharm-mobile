package com.hader.pharma

import android.bluetooth.*
import android.content.*
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

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

                    "getDevices" -> {
                        result.success(discoveredDevices.values.toList())
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

    override fun onDestroy() {
        super.onDestroy()
        try {
            unregisterReceiver(receiver)
        } catch (_: Exception) {
        }
    }
}
