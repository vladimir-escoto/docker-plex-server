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
# Editar .env con tu configuración
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
Obtener token de Plex: Visita plex.tv/claim

Configurar VPN: Edita la configuración de Gluetun

Configurar rutas: Ajusta las rutas de almacenamiento en .env

Configuración de Servicios
Cada servicio está preconfigurado para integrarse automáticamente:

Prowlarr → Provee indexadores a Radarr/Sonarr

Overseerr → Permite solicitudes desde interfaz web

qBittorrent → Descarga a través de VPN automáticamente

Bazarr → Sincroniza subtítulos automáticamente

🎯 Flujo de Trabajo
Solicitar contenido a través de Overseerr

Búsqueda automática por Radarr/Sonarr

Descarga segura via qBittorrent + VPN

Organización automática en bibliotecas

Disponible instantáneamente en Plex

🔧 Mantenimiento
### Limpieza automática de descargas
Los scripts de limpieza eliminan los archivos antiguos de las carpetas de descargas completadas (30 días) e incompletas (7 días).

Variables disponibles:

- `MEDIA_ROOT`: Ruta base del almacenamiento multimedia. Valor predeterminado: `/docker-services/media` en Linux/macOS o `C:\docker-services\media` en Windows.
- `DOWNLOADS_ROOT`: Carpeta de descargas dentro de `MEDIA_ROOT`. Valor predeterminado: `<MEDIA_ROOT>/downloads`.
- `COMPLETED_DIR`: Carpeta de descargas completadas. Valor predeterminado: `<DOWNLOADS_ROOT>/completed`.
- `INCOMPLETE_DIR`: Carpeta de descargas incompletas. Valor predeterminado: `<DOWNLOADS_ROOT>/incomplete`.

#### Ejecución manual
- Linux/macOS: `MEDIA_ROOT=/ruta/a/media DOWNLOADS_ROOT=/ruta/a/downloads ./scripts/cleanup.sh`
- Windows PowerShell: `Set-Location <ruta-del-repo>; $env:MEDIA_ROOT='D:\\media'; .\\scripts\\cleanup.ps1`

#### Programación automática
- Linux/macOS (cron): `0 3 * * * MEDIA_ROOT=/ruta/a/media DOWNLOADS_ROOT=/ruta/a/downloads /ruta/al/repo/scripts/cleanup.sh >> /var/log/cleanup.log 2>&1`
- Windows (Task Scheduler): Crear una tarea programada diaria que ejecute `powershell.exe -File "C:\ruta\al\repo\scripts\cleanup.ps1"`, configurando las variables de entorno en la tarea si es necesario.

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
