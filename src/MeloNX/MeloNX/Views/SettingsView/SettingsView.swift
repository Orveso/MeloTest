//
//  SettingsView.swift
//  MeloNX
//
//  Created by Stossy11 on 25/11/2024.
//

import SwiftUI

struct SettingsView: View {
    @Binding var config: Ryujinx.Configuration
    @Binding var MoltenVKSettings: [MoltenVKSettings]
    
    var memoryManagerModes = [
        ("HostMappedUnsafe", "Host Unchecked (fastest, unstable / unsafe)"),
        ("HostMapped", "Host (fast)"),
        ("SoftwarePageTable", "Software")
    ]
    
    var vsyncModes = [
        ("Switch", "Switch"),
        ("Unbound", "Unbound"),
    ]
    
    @AppStorage("RyuDemoControls") var ryuDemo: Bool = false
    @AppStorage("MTL_HUD_ENABLED") var metalHUDEnabled: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                Section(header: Text("Graphics and Performance").bold()) {
                    Toggle("Ryujinx Fullscreen", isOn: $config.fullscreen)
                    Picker("V-Sync", selection: $config.vsync) {
                        ForEach(vsyncModes, id: \.0) { key, displayName in
                            Text(displayName).tag(key)
                        }
                    }
                    Toggle("Disable Shader Cache", isOn: $config.disableShaderCache)
                    Toggle("Enable Texture Recompression", isOn: $config.enableTextureRecompression)
                    Toggle("Disable Docked Mode", isOn: $config.disableDockedMode)
                    Resolution(value: $config.resscale)
                    Toggle("Enable Metal HUD", isOn: $metalHUDEnabled)
                        .onChange(of: metalHUDEnabled) { newValue in
                            if newValue {
                                MTLHud.shared.enable()
                            } else {
                                MTLHud.shared.disable()
                            }
                        }
                }
                
                Section(header: Text("Input Settings").bold()) {
                    Toggle("List Input IDs", isOn: $config.listinputids)
                    Toggle("Nintendo Controller Layout", isOn: $config.nintendoinput)
                    Toggle("Ryujinx Demo On-Screen Controller", isOn: $ryuDemo)
                    // Toggle("Host Mapped Memory", isOn: $config.hostMappedMemory)
                    Toggle("Disable Docked Mode", isOn: $config.disableDockedMode)
                }
                
                Section(header: Text("Logging Settings").bold()) {
                    Toggle("Enable Debug Logs", isOn: $config.debuglogs)
                    Toggle("Enable Trace Logs", isOn: $config.tracelogs)
                }
                
                Section(header: Text("CPU Mode").bold()) {
                    HStack {
                        Spacer()
                        Picker("Memory Manager Mode", selection: $config.memoryManagerMode) {
                            ForEach(memoryManagerModes, id: \.0) { key, displayName in
                                Text(displayName).tag(key)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()) // Dropdown style
                    }
                }
                
                Section(header: Text("Network").bold()) {
                    Toggle("Enable Ryujinx LDN", isOn: $config.ryuLDN)
                }
                
                Section(header: Text("Additional Settings")) {
                    //TextField("Game Path", text: $config.gamepath)
                    
                    Text("PageSize \(String(Int(getpagesize())))")
                    
                    TextField("Additional Arguments", text: Binding(
                        get: {
                            config.additionalArgs.joined(separator: ", ")
                        },
                        set: { newValue in
                            config.additionalArgs = newValue.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
                        }
                    ))
                }
            }
        }
        .padding()
        .onAppear {
            if let configs = loadSettings() {
                self.config = configs
                print(configs)
            }
        }
        .navigationTitle("Settings")
        .navigationBarItems(trailing: Button("Save") {
            saveSettings()
        })
    }
    
    func saveSettings() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // Optional: Makes the JSON easier to read
            let data = try encoder.encode(config)
            let jsonString = String(data: data, encoding: .utf8)
            
            // Save to UserDefaults
            UserDefaults.standard.set(jsonString, forKey: "config")
            
            print("Settings saved successfully!")
        } catch {
            print("Failed to save settings: \(error)")
        }
    }
}


struct Resolution: View {
    @Binding var value: Float

    var body: some View {
        HStack {
            Text("Resolution Scale (Custom):")
            Spacer()
            
            Button(action: {
                if value > 0.1 { // Prevent values going below 0.1
                    value -= 0.10
                    value = round(value * 1000) / 1000 // Round to two decimal places
                }
                print(value)
            }) {
                Text("-")
                    .frame(width: 30, height: 30)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
            }
            
            TextField("", value: $value, formatter: NumberFormatter.floatFormatter)
                .multilineTextAlignment(.center)
                .frame(width: 60)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.decimalPad)
            
            Button(action: {
                value += 0.10
                value = round(value * 1000) / 1000 // Round to two decimal places
                print(value)
            }) {
                Text("+")
                    .frame(width: 30, height: 30)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5)
            }
        }
    }
}

extension NumberFormatter {
    static var floatFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.allowsFloats = true
        return formatter
    }
}
