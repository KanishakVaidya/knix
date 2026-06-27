{ config, lib, pkgs, ... }:
{
  specialisation.VFIO.configuration = {
    system.nixos.tags = [ "with-vfio" ];
    boot = {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"
        # "vfio_virqfd"

        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      kernelParams = [
        # enable IOMMU
        "amd_iommu=on"
        "iommu=pt"
        "vfio-pci.ids=10de:1f12,10de:10f9,10de:1ada,10de:1adb"
      ];
    };

    services.xserver.videoDrivers = [ "amdgpu" ];

    hardware.nvidia = {
      modesetting.enable = false;
      powerManagement.enable = false;
      open = false;
    };

    hardware.opengl.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    programs.virt-manager.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
}
