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
## Requisitos
- Docker Engine 24+ y Docker Compose Plugin 2.20+ instalados
- Sistema operativo Windows 11, Linux o macOS con soporte para contenedores
- Conexión a internet estable para descargas y actualización de contenedores
- Al menos 200 GB de almacenamiento libre (recomendado) para la biblioteca multimedia
- 8 GB de RAM mínimo recomendado para un funcionamiento fluido

## Guía de despliegue
1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tuusuario/media-server-setup.git
   cd media-server-setup
   ```
2. **Preparar el archivo de variables de entorno**
   ```bash
   cp .env.example .env
   # Edita .env con tus rutas, credenciales y claves API
   ```
3. **Generar secretos seguros**
   Reemplaza los valores por defecto de los archivos `authelia_encryption.txt`, `authelia_session.txt`, `authelia_jwt.txt` y `postgres_secret.txt` con cadenas generadas de forma segura.
   ```bash
   openssl rand -hex 64 | tee authelia_encryption.txt
   openssl rand -hex 64 | tee authelia_session.txt
   openssl rand -hex 64 | tee authelia_jwt.txt
   openssl rand -hex 32 | tee postgres_secret.txt
   ```
4. **Crear directorios persistentes**
   ```bash
   mkdir -p config/{authelia,bazarr,npm,overseerr,plex,prowlarr,qbittorrent,radarr,sonarr,tdarr}
   mkdir -p media/{downloads,movies,music,tv}
   ```
5. **Asignar permisos adecuados**
   ```bash
   sudo chown -R $USER:$USER config media
   sudo chmod -R 755 config media
   ```
   > En entornos NAS o servidores remotos ajusta usuario/grupo según corresponda.
6. **Iniciar los servicios**
   ```bash
   docker compose up -d
   ```

## Acceso rápido a los servicios
Una vez que los contenedores estén en ejecución, accede a las interfaces web desde tu navegador:

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

🧩 Servicios y puertos principales
| Servicio | Puerto | Rol principal |
|----------|-------|---------------|
| Plex Media Server | 32400 | Servidor de streaming y transcodificación multimedia |
| Overseerr | 5055 | Portal de solicitudes para usuarios finales |
| Radarr | 7878 | Automatización de descargas de películas |
| Sonarr | 8989 | Automatización de descargas de series |
| Bazarr | 6767 | Gestión automática de subtítulos |
| Tdarr | 8265 | Optimización y transcodificación de medios |
| qBittorrent | 8080 | Cliente torrent integrado con VPN |
| Prowlarr | 9696 | Agregador de indexadores para Radarr/Sonarr |
| Nginx Proxy Manager | 81 / 443 | Proxy inverso, certificados SSL y redirecciones |
| Authelia | 9091 | Autenticación de dos factores y SSO |
| Gluetun (VPN) | 8000/1194 | Túnel VPN y cortafuegos para tráfico de descargas |
| PostgreSQL | 5432 | Base de datos para Authelia y servicios auxiliares |

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
