# workstation-server-config

Migration deiner bisherigen monolithischen `configuration.nix` in die
Host/Module/User-Struktur, plus neuer `gaming`-User.

## Vor dem ersten `nixos-rebuild switch`

1. `hosts/workstation-server/hardware.nix` ist ein Platzhalter - dein echtes
   `/etc/nixos/hardware-configuration.nix` war nicht in den
   hochgeladenen Dateien. Kopiere den Inhalt 1:1 rein, bevor du baust.
2. `nix flake check` bzw. `nixos-rebuild build --flake .#Workstation-Server`
   laufen lassen, bevor du `switch` machst - insbesondere weil hier
   erstmals zwei Home-Manager-User gleichzeitig aktiv sind.
3. Der `gaming`-User hat aktuell keinen Weg, tatsächlich etwas auf
   einen Bildschirm zu bekommen (siehe Kommentar in
   `modules/home/gaming.nix`). Das ist bewusst offen gelassen, nicht
   vergessen.

## Was sich wo befindet

| Datei | Inhalt | Warum dort |
| --- | --- | --- |
| `hosts/workstation-server/default.nix` | Hostname, Bootloader, Kernel, statische IP | Alles, was garantiert nicht auf einen zweiten Host passt |
| `modules/nixos/core.nix` | Locale, Keyboard, SSH, Nix-Settings/GC, journald | Würde auf jedem zukünftigen Host identisch sein |
| `modules/nixos/gpu.nix` | ROCm/OpenCL, nix-ld, GPU-Powermanagement | Sowohl für Open WebUI (Compute) als auch für den gaming-User relevant |
| `modules/nixos/server-services.nix` | playit, open-webui, opencloud, HDD-Spindown, Nacht-Shutdown | Alles, was mit den Diensten steht und fällt - kein separater User nötig |
| `users/felix/` | SSH-Keys + Home-Profil | Deine bisherige `users.users.felix` 1:1 übernommen |
| `users/gaming/` | Neuer User, kein sudo, keine SSH-Keys per Default | Siehe Annahme im Kommentar - ändern falls falsch |

## Nicht übernommen / bewusst ausgelassen

- **disko**: dein System läuft bereits, `disko` würde eine
  Neupartitionierung voraussetzen. Kein Drop-in.
- **Secrets**: `services.opencloud.environmentFile` zeigt weiterhin
  auf `/etc/opencloud/secrets.env` außerhalb des Nix-Stores - das ist
  aktuell richtig so und sollte es bleiben, bis du sops-nix/agenix
  einführst. Committe diese Datei niemals ins Repo.
