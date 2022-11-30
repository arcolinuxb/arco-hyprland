#https://github.com/Ubuntu-Sway/ubuntusway-default-settings/blob/lunar/etc/profile.d/sway.sh

# Set XDG_CURRENT_DESKTOP to Hyprland (for screencasting and screensharing capabilities)
export XDG_CURRENT_DESKTOP=hyprland

# Ubuntu Sway specific config dir
export XDG_CONFIG_DIRS=/etc/xdg

# Force Wayland for Mozilla Firefox
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1

# Force Wayland for Qt apps
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME=qt5ct

# Force Wayland for EFL (Enlightenment) apps
export ECORE_EVAS_ENGINE="wayland-egl"
export ELM_ACCEL="gl"

# Java XWayland blank screens fix
export _JAVA_AWT_WM_NONREPARENTING=1

# Check if system is running in virtual machine
case "$(systemd-detect-virt)" in
qemu)
  export WLR_RENDERER=pixman
  export WLR_NO_HARDWARE_CURSORS=1
  ;;
kvm)
  export WLR_NO_HARDWARE_CURSORS=1
  ;;
oracle)
  export WLR_NO_HARDWARE_CURSORS=1
  ;;
esac

# Apply Nvidia-specific variables
CHK_DRV=$(lspci -k | grep -A 2 -i "VGA" | awk 'NR==3' | awk -F: '{ print $2 }' | sed 's/^[ \t]*//g')

if [ "$CHK_DRV" = "nvidia" ]; then
    export WLR_NO_HARDWARE_CURSORS=1
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
fi
