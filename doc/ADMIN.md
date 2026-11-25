To switch the app from demo mode to the full font list, open the app's config panel in the webadmin and paste a free 'Web Fonts Developer API' key (created at <https://console.cloud.google.com/apis/library/webfonts.googleapis.com>) into the Google Fonts API key field. The service restarts automatically.

The key lives in `__INSTALL_DIR__/.env`, the font archive cache in the app data directory. Logs are in `/var/log/__APP__/__APP__.log`.
