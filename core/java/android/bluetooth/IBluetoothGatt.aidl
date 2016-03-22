/*
 * Copyright (C) 2013 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.bluetooth;

import android.bluetooth.BluetoothDevice;
import android.bluetooth.le.AdvertiseSettings;
import android.bluetooth.le.AdvertiseData;
import android.bluetooth.le.ScanFilter;
import android.bluetooth.le.ScanSettings;
import android.bluetooth.le.ResultStorageDescriptor;
import android.os.ParcelUuid;

import android.bluetooth.IBluetoothGattCallback;
import android.bluetooth.IBluetoothGattServerCallback;

/**
 * API for interacting with BLE / GATT
 * @hide
 */
interface IBluetoothGatt {
    List<BluetoothDevice> getDevicesMatchingConnectionStates(in int[] states);

    void startScan(in int appIf, in boolean isServer, in ScanSettings settings,
                   in List<ScanFilter> filters,
                   in List scanStorages, in String callingPackage);
    void stopScan(in int appIf, in boolean isServer);
    void flushPendingBatchResults(in int appIf, in boolean isServer);
    void startMultiAdvertising(in int appIf,
                               in AdvertiseData advertiseData,
                               in AdvertiseData scanResponse,
                               in AdvertiseSettings settings);
    void stopMultiAdvertising(in int appIf);
    void registerClient(in ParcelUuid appId, in IBluetoothGattCallback callback);
    void unregisterClient(in int clientIf);
    void clientConnect(in int clientIf, in String address, in boolean isDirect, in int transport);
    void clientDisconnect(in int clientIf, in String address);
    void refreshDevice(in int clientIf, in String address);
    void discoverServices(in int clientIf, in String address);
    void readCharacteristic(in int clientIf, in String address, in int handle, in int authReq);
    void writeCharacteristic(in int clientIf, in String address, in int handle,
                            in int writeType, in int authReq, in byte[] value);
    void readDescriptor(in int clientIf, in String address, in int handle, in int authReq);
    void writeDescriptor(in int clientIf, in String address, in int handle,
                            in int writeType, in int authReq, in byte[] value);
    void registerForNotification(in int clientIf, in String address, in int handle, in boolean enable);
    void beginReliableWrite(in int clientIf, in String address);
    void endReliableWrite(in int clientIf, in String address, in boolean execute);
    void readRemoteRssi(in int clientIf, in String address);
    void configureMTU(in int clientIf, in String address, in int mtu);
    void connectionParameterUpdate(in int clientIf, in String address, in int connectionPriority);

    void registerServer(in ParcelUuid appId, in IBluetoothGattServerCallback callback);
    void unregisterServer(in int serverIf);
    void serverConnect(in int servertIf, in String address, in boolean isDirect, in int transport);
    void serverDisconnect(in int serverIf, in String address);
    void beginServiceDeclaration(in int serverIf, in int srvcType,
                            in int srvcInstanceId, in int minHandles,
                            in ParcelUuid srvcId, boolean advertisePreferred);
    void addIncludedService(in int serverIf, in int srvcType,
                            in int srvcInstanceId, in ParcelUuid srvcId);
    void addCharacteristic(in int serverIf, in ParcelUuid charId,
                            in int properties, in int permissions);
    void addDescriptor(in int serverIf, in ParcelUuid descId,
                            in int permissions);
    void endServiceDeclaration(in int serverIf);
    void removeService(in int serverIf, in int srvcType,
                            in int srvcInstanceId, in ParcelUuid srvcId);
    void clearServices(in int serverIf);
    void sendResponse(in int serverIf, in String address, in int requestId,
                            in int status, in int offset, in byte[] value);
    void sendNotification(in int serverIf, in String address, in int srvcType,
                            in int srvcInstanceId, in ParcelUuid srvcId,
                            in int charInstanceId, in ParcelUuid charId,
                            in boolean confirm, in byte[] value);
    void disconnectAll();
    void unregAll();
    int numHwTrackFiltersAvailable();
}
