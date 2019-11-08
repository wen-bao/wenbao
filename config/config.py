"""
配置信息
"""

class FlaskConfig:
    """
    flask配置
    """
    # caution: 在生产环境必须把debug模式关闭
    DEBUG = True

class EXPOSE_CFG(object):

    LOG = {
        'log_dir': '/saas/projects/assets_api/log',
        'log_level': 'debug',
        'log_type': 'TimedRotatingFileHandler'
    }

    tmp_dir = '/saas/projects/assets_api/data'

    NEO4J = {
        'host': '10.251.1.222',
        'port': 7687,
        'username': 'neo4j',
        'password': 'sangfor'
    }
