{ config, lib, pkgs, modulesPath, ... }:
{
  specialisation.battery.configuration = {
    # 1. GPU: Nuclear Option
    # We don't just blacklist; we tell the kernel to disable the device power
    boot.blacklistedKernelModules = [ "nvidia" "nouveau" "nvidia_drm" "nvidia_modeset" ];
    
    # Disable turbo boost (big battery saver)
    boot.kernelParams = [ "amd_pstate=active" ];  # OR amd_pstate=active
    
    services.xserver.videoDrivers = [ "amdgpu" ];
    
    # This udev rule completely suspends the NVIDIA GPU at the hardware level
    services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{remove}="1"
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", ATTR{remove}="1"
        '';
    
    # 2. CPU Management
    # Use the modern amd_pstate driver for much better efficiency than the old acpi-cpufreq
    boot.kernelParams = [ 
      "amd_pstate=active" 
      "maxcpus=8" # Limits to 8 logical cores (4 physical cores with SMT)
    ];
    
    powerManagement.cpuFreqGovernor = "powersave";
    
    # 3. TLP: The Gold Standard
    services.tlp.enable = true;
    services.tlp.settings = {
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      # Limit the CPU boost
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      # Maximize PCIe power savings
      PCIE_ASPM_ON_BAT = "powersupersave";
      # Scaling frequencies are in kHz
      # 1.0 GHz = 1000000 | 1.2 GHz = 1200000
      CPU_SCALING_MIN_FREQ_ON_BAT = 400000;  # Allow it to idle low
      CPU_SCALING_MAX_FREQ_ON_BAT = 1500000; # Cap it at 1.5 GHz
      
      # Ensure the governor doesn't try to override this
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
    
    # 4. Miscellaneous
    # Keep fstrim enabled (it's a background timer, won't hurt battery much), 
    # but disable heavy indexing if you use it (like updatedb or locate).
    
    # Turn off Bluetooth if you don't use it while traveling
    hardware.bluetooth.enable = false;
    
    # PowerTop is great for monitoring, but TLP handles the tuning better
    powerManagement.powertop.enable = false; 
  };
}
