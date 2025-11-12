🎬 Servidor de Medios Automatizado con Docker
📖 Descripción del Proyecto
Este repositorio contiene la configuración completa para implementar un servidor de medios automatizado y escalable usando contenedores Docker. El sistema permite gestionar, descargar, organizar y reproducir contenido multimedia de manera completamente automática, proporcionando una experiencia similar a servicios de streaming comerciales pero con control total sobre tu contenido.

✨ Características Principales
🎥 Biblioteca Multimedia Centralizada: Películas, series, música y libros en un solo lugar

⚡ Automatización Completa: Búsqueda, descarga, organización y optimización automática

🔒 Seguridad Integrada: VPN, autenticación y proxy reverso con SSL

📱 Acceso Multiplataforma: Compatible con TV, móviles, tablets y navegadores

🚀 Escalable: Diseñado para crecer desde un PC personal hasta un servidor dedicado

🏗️ Plan de Implementación por Etapas Funcionales
Etapa 1: Núcleo Esencial de Medios ⭐
Objetivo: Sistema básico funcionando

text
✅ Plex Media Server - Servidor de medios principal
✅ Radarr (Películas) - Gestión automática de películas
✅ Sonarr (Series) - Gestión automática de series
✅ qBittorrent (Descargas) - Cliente de descargas torrent
✅ Prowlarr (Indexadores) - Agregador de indexadores
✅ Overseerr (Solicitudes) - Interfaz de solicitudes de contenido
Resultado: Podrás buscar, solicitar y ver contenido básico de forma automatizada

Etapa 2: Automatización y Organización 🔄
Objetivo: Reducir intervención manual

text
🔄 Bazarr (Subtítulos automáticos) - Descarga y sincronización de subtítulos
🔄 Tdarr (Optimización de medios) - Transcodificación y optimización automática
🔄 Notificaciones (Telegram/Discord) - Alertas y notificaciones inteligentes
🔄 Limpieza automática de descargas - Mantenimiento y organización automática
Resultado: Sistema se auto-mantiene y optimiza sin intervención manual

Etapa 3: Seguridad y Acceso 🔒
Objetivo: Acceso seguro desde cualquier lugar

text
🔒 Nginx Proxy Manager (SSL/Reverse Proxy) - Proxy reverso con certificados SSL
🔒 Autenticación centralizada (Authelia) - SSO y autenticación de dos factores
🔒 VPN para descargas (Gluetun) - Tunelización segura para descargas
🔒 Backup de configuraciones - Sistema de respaldo automático
Resultado: Acceso remoto seguro y protegido desde cualquier dispositivo

🚀 Comenzando
Prerrequisitos
Docker y Docker Compose instalados

Windows 11, Linux, o macOS

Mínimo 8GB RAM recomendado

Almacenamiento suficiente para tu biblioteca multimedia

Instalación Rápida
Clonar el repositorio:

bash
git clone https://github.com/tuusuario/media-server-setup.git
cd media-server-setup
Configurar variables de entorno:

bash
cp .env.example .env
# Edita .env con tus rutas, identificadores y credenciales

Para generar secretos seguros (por ejemplo para `POSTGRES_PASSWORD`) puedes ejecutar:

bash
openssl rand -hex 32
Ejecutar el sistema:

bash
docker-compose up -d
Acceder a los servicios:

Plex: http://localhost:32400

Overseerr: http://localhost:5055

Radarr: http://localhost:7878

Sonarr: http://localhost:8989

📁 Estructura del Proyecto
text
media-server-setup/
├── 📁 config/                 # Configuraciones persistentes
│   ├── plex/
│   ├── radarr/
│   ├── sonarr/
│   └── ...
├── 📁 media/                  # Biblioteca multimedia
│   ├── movies/
│   ├── tv/
│   ├── music/
│   └── downloads/
├── 📄 docker-compose.yml      # Orquestación de servicios
├── 📄 .env                    # Variables de entorno
├── 📄 setup.bat              # Script de instalación Windows
└── 📄 README.md              # Esta documentación
⚙️ Configuración
Configuración Básica
Variables de entorno clave (todas documentadas en `.env.example`):

- `TIMEZONE`: Zona horaria para los contenedores.
- `CONFIG_PATH`: Carpeta persistente para configuraciones.
- `MEDIA_PATH`: Ruta raíz de la biblioteca multimedia. Valor predeterminado: `/data/media`.
- `PUID` / `PGID`: Usuario y grupo del host que poseerán los archivos.
- `PLEX_CLAIM_TOKEN`: Token opcional para reclamar Plex (https://plex.tv/claim).
- `POSTGRES_PASSWORD`: Contraseña del usuario principal de Postgres (genera un valor seguro con `openssl rand -hex 32`).
- `VPN_SERVICE_PROVIDER`, `VPN_TYPE`, `SERVER_REGIONS`: Ajustes del contenedor Gluetun según tu proveedor VPN.

Configura estos valores antes de levantar los servicios para adaptarlos a tu entorno.

### Cómo obtener `PUID`/`PGID`

- **Linux y macOS**: ejecuta `id -u` para obtener el UID y `id -g` para el GID del usuario que administrará la biblioteca.
- **WSL (Windows Subsystem for Linux)**: abre tu distribución (Ubuntu, Debian, etc.) y usa los mismos comandos `id -u` / `id -g`. Los valores devueltos son los que debes usar en `.env`.

### Opciones de rutas en Windows

1. **Usar WSL2** (recomendado): crea los directorios persistentes dentro de la distribución (por ejemplo, `mkdir -p /data/media /data/config`) y ejecuta Docker desde WSL (`docker compose up -d`).
2. **Docker Desktop con bind mounts**: comparte la unidad deseada en Docker Desktop y define rutas en formato POSIX, por ejemplo `MEDIA_PATH=//c/Users/tu_usuario/Media` y `CONFIG_PATH=//c/Users/tu_usuario/Config`.

Configuración de Servicios
Cada servicio está preconfigurado para integrarse automáticamente:

Prowlarr → Provee indexadores a Radarr/Sonarr

Overseerr → Permite solicitudes desde interfaz web

qBittorrent → Descarga a través de VPN automáticamente

Bazarr → Sincroniza subtítulos automáticamente

🔐 Ajustes de Authelia (Usuarios, Correo y 2FA)

Los servicios protegidos por Authelia se controlan desde `config/authelia/configuration.yml` y el archivo de usuarios `config/authelia/users_database.yml`.

1. **Usuarios y contraseñas**
   - Edita `config/authelia/users_database.yml` para actualizar nombres, correos y pertenencia a grupos.
   - Las contraseñas deben estar en formato Argon2id. Puedes generar un hash seguro con:

     ```bash
     docker run --rm authelia/authelia:latest authelia crypto hash generate argon2 --password 'TuContraseñaSegura'
     ```

     Copia el valor de `Digest` en el campo `password` del usuario correspondiente.

2. **Secretos y llaves**
   - Genera valores aleatorios de al menos 32 caracteres para `jwt_secret`, `session.secret`, `storage.encryption_key` y la contraseña de la base de datos (`storage.postgres.password`). Puedes reutilizar los archivos de este repositorio (`authelia_jwt.txt`, `authelia_encryption.txt`, `authelia_session.txt`, `postgres_secret.txt`) o crear los tuyos propios y pegarlos en `config/authelia/configuration.yml`.
   - Si usas Docker secrets o variables de entorno, ajusta las rutas/valores en el archivo de configuración para que apunten a esos secretos.

3. **Políticas de acceso y 2FA**
   - Ajusta `access_control.rules` en `config/authelia/configuration.yml` para definir qué dominios requieren 2FA, 1FA o acceso libre.
   - Configura `totp_secret` para cada usuario que requiera autenticación de dos factores. Puedes generar uno nuevo con:

     ```bash
     docker run --rm authelia/authelia:latest authelia tools totp generate --issuer 'TuDominio' --account 'usuario@tu-dominio.com'
     ```

     Escanea el código QR generado en tu aplicación de autenticación (por ejemplo, Authy o Google Authenticator).

🎯 Flujo de Trabajo
Solicitar contenido a través de Overseerr

Búsqueda automática por Radarr/Sonarr

Descarga segura via qBittorrent + VPN

🎯 Flujo de Trabajo
1. **Autenticación y acceso seguro**
   - El tráfico entrante se gestiona mediante **Nginx Proxy Manager** (SSL) y **Authelia** (SSO + 2FA) para proteger todas las aplicaciones expuestas.
   - **Gluetun** enruta las descargas a través de una VPN dedicada, aislando el tráfico sensible del resto de la red.
2. **Automatización de contenidos**
   - Los usuarios realizan solicitudes en **Overseerr**, que comunica las peticiones a **Radarr** (películas) y **Sonarr** (series).
   - **Prowlarr** proporciona los indexadores a Radarr/Sonarr, mientras que **qBittorrent** gestiona las descargas dentro del túnel VPN.
   - Tras la descarga, **Bazarr** sincroniza subtítulos y **Tdarr** optimiza los archivos antes de que **Plex** los sirva en la biblioteca.
3. **Respaldo y mantenimiento**
   - Todos los contenedores montan volúmenes persistentes en `config/` y `media/`, lo que facilita la creación de copias de seguridad programadas.
   - Se recomienda automatizar respaldos periódicos (por ejemplo, con `cron` o tareas programadas) y utilizar el script `limpieza_automatica.bat` como referencia para depurar descargas temporales.

🔧 Mantenimiento
### Limpieza automática de descargas
Los scripts de limpieza eliminan los archivos antiguos de las carpetas de descargas completadas (30 días) e incompletas (7 días).

Variables disponibles:

- `MEDIA_ROOT`: Ruta base del almacenamiento multimedia. Valor predeterminado: `/data/media`.
- `DOWNLOADS_ROOT`: Carpeta de descargas dentro de `MEDIA_ROOT`. Valor predeterminado: `<MEDIA_ROOT>/downloads`.
- `COMPLETED_DIR`: Carpeta de descargas completadas. Valor predeterminado: `<DOWNLOADS_ROOT>/completed`.
- `INCOMPLETE_DIR`: Carpeta de descargas incompletas. Valor predeterminado: `<DOWNLOADS_ROOT>/incomplete`.

#### Ejecución manual
- Linux/macOS/WSL: `MEDIA_ROOT=/ruta/a/media DOWNLOADS_ROOT=/ruta/a/downloads ./scripts/cleanup.sh`
- Windows (PowerShell con Docker Desktop): `Set-Location <ruta-del-repo>; $env:MEDIA_ROOT='//c/Users/<usuario>/Media'; ./scripts/cleanup.ps1`

#### Programación automática
- Linux/macOS/WSL (cron): `0 3 * * * MEDIA_ROOT=/ruta/a/media DOWNLOADS_ROOT=/ruta/a/downloads /ruta/al/repo/scripts/cleanup.sh >> /var/log/cleanup.log 2>&1`
- Windows (Task Scheduler + Docker Desktop): Crear una tarea diaria que ejecute `powershell.exe -Command "Set-Location '<ruta-del-repo>'; ./scripts/cleanup.ps1"` y establezca previamente `MEDIA_ROOT`/`DOWNLOADS_ROOT` en formato POSIX (`//c/...`).

Comandos Útiles
bash
# Iniciar todos los servicios
docker-compose up -d

# Ver logs en tiempo real
docker-compose logs -f

# Detener servicios
docker-compose down

# Actualizar contenedores
docker-compose pull
docker-compose up -d
Backup y Restauración
Las configuraciones se persisten en ./config/

Realiza backup regular de la carpeta config/

La biblioteca multimedia en ./media/ contiene tu contenido

🤝 Contribuciones
Las contribuciones son bienvenidas. Por favor:

Fork el proyecto

Crea una rama para tu feature (git checkout -b feature/AmazingFeature)

Commit tus cambios (git commit -m 'Add some AmazingFeature')

Push a la rama (git push origin feature/AmazingFeature)

Abre un Pull Request

📄 Licencia
Este proyecto está bajo la Licencia MIT - ver el archivo LICENSE.md para detalles.

⚠️ Aviso Legal
Este software está destinado para uso personal con contenido para el que tengas derechos legales. Los desarrolladores no se hacen responsables del uso indebido del mismo.

🛣️ Próximas Etapas
Una vez completadas las primeras 3 etapas, puedes continuar con:

📊 Etapa 4: Monitorización y Analytics

🎵 Etapa 5: Expansión de Contenido (Música, Libros)

🤖 Etapa 6: Experiencia de Usuario Avanzada

¿Necesitas ayuda? Revisa los issues o abre uno nuevo para soporte.

¿Listo para transformar tu experiencia multimedia? 🚀
