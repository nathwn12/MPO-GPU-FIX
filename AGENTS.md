# MPO-GPU-FIX

## Project

Windows Forms app (.NET 10) for toggling GPU registry fixes (MPO, TDR, ULPS, shader cache, overlays, HAGS, DX Navi switching, MSI support). Targets `net10.0-windows`, single-file publish, `win-x64`.

## Build

```bash
dotnet publish AMDGPUFIX/AMDGPUFIX/AMDGPUFIX.csproj -c Release
# or
build-mpo-gpu-fix.bat
```

Output at `bin/Release/net10.0-windows/win-x64/publish/` or desktop (bat script).

Prerequisites: .NET 10 SDK, Windows x64.

## Architecture

- **Entrypoint**: `Program.cs` -> `EmbeddedAssembly.Load("MaterialSkin.zip")` -> `Application.Run(new Preload())` -> `Preload` constructor calls `Application.Run(new Form1())`
- **Single-form app** (`Form1.cs`) with modal sub-forms: `dxmod` (DX Navi switching), `bsodfix` (MSI support)
- **Registry access** via `Microsoft.Win32` throughout; requires admin (enforced in `Form1.CheckAdminRights`, manifest `requireAdministrator`)
- **MaterialSkin** UI library loaded from embedded zip resource (not NuGet); `MaterialSkin.dll` at `AMDGPUFIX/AMDGPUFIX/Resources/MaterialSkin.zip`
- **External dep**: `System.Management` v9.0.0 NuGet (WMI queries for GPU info)
- **Static registry keys** stored as static fields in `Form1`; opened once, never disposed

## Key files

| File | Purpose |
|------|---------|
| `Form1.cs` | Main form, all toggle handlers, GPU detection |
| `DXHandler.cs` | DX Navi profile switching (D3D driver DLL swapping) |
| `ULPS.cs` | Ultra-Low Power State toggle |
| `SHADERCACHE.cs` | AMD shader cache registry value management |
| `bsodfix.cs` | MSI support toggle per PCI device |
| `WMIFix.cs` | WMI repair helper |

## Code conventions & gotchas

- Registry `OpenSubKey` calls are never disposed — intentional for simplicity. Don't add `using` blocks unless creating new code.
- Empty `catch` blocks have explanatory comments; don't remove them without understanding the registry access failure context.
- Null guards (`key != null && key.GetValue(...) != null`) are used on all `OpenSubKey` results — replicate this pattern in new code.
- `Preload.cs` constructor calls `Application.Run(new Form1())` — unusual pattern but required for splash behavior.
