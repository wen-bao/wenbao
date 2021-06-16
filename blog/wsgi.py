"""
WSGI config for myblog project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/2.2/howto/deployment/wsgi/
"""
import os

from django.core.wsgi import get_wsgi_application

SETTINGS = "blog.settings.development"

if os.environ.get("ENV", None) == "staging":
    SETTINGS = "blog.settings.staging"

os.environ.setdefault("DJANGO_SETTINGS_MODULE", SETTINGS)

application = get_wsgi_application()
