## MPO-GPU-FIX

Windows utility for toggling MPO-related fixes and a small set of related GPU registry options when MPO or overlays are causing instability, flicker, stutter, or browser/streaming issues.

## Repository Status

- Maintained at `nathwn12/MPO-GPU-FIX`
- Originates as a fork of `RedDot-3ND7355/MPO-GPU-FIX`
- Current notable update: migrated to `.NET 10`

## Use

1. Run the tool.
2. Enable the fix you want.
3. Reboot when prompted.

To restore MPO, turn the MPO fix off and reboot again.

## Warnings

- `Disable Overlays` is a last-resort option and can cause issues in some DX12 games.
- `Disable Overlays` makes the MPO and `OverlayMinFPS` fixes unnecessary.
- Do not disable ULPS on Radeon RX 9000 series GPUs; users have reported instability and crashes.
- Test changes after reboot instead of enabling multiple optional fixes blindly.

## Build

Prerequisites:

- Windows 10/11 x64
- [.NET 10 SDK](https://dotnet.microsoft.com/download/dotnet/10.0)
- Git

Build command:

```bash
dotnet publish AMDGPUFIX/AMDGPUFIX/AMDGPUFIX.csproj -c Release
```

Output path:

`bin/Release/net10.0-windows/win-x64/publish/`

Optional one-command build:

```bat
build-mpo-gpu-fix.bat
```

This script places `MPOGPUFIX.exe` on the desktop.

## References

- Wiki: <https://github.com/RedDot-3ND7355/MPO-GPU-FIX/wiki>
- Still having issues: <https://github.com/RedDot-3ND7355/MPO-GPU-FIX/wiki/Still-getting-issues%3F>
