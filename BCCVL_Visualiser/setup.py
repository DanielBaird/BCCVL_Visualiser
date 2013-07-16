import os

from setuptools import setup, find_packages

here = os.path.abspath(os.path.dirname(__file__))
README = open(os.path.join(here, 'README.txt')).read()
CHANGES = open(os.path.join(here, 'CHANGES.txt')).read()

requires = [
    'pyramid',
    'SQLAlchemy',
    'GeoAlchemy2',
    'psycopg2',
    'dogpile.cache',    # cache regions, lets you cache the result of queries

    # mapscript is now installed during the buildout.
    # it is installed using the cmmi recipe (configure && make && make install)
    #
    # 'mapscript',      # Python Map Server implementation


    'PIL',              # Python Imaging Library
    'shapely',          # PostGIS-ish operations in python
    'transaction',
    'pyramid_tm',
    'pyramid_debugtoolbar',
    'zope.sqlalchemy',
    'requests',
    'waitress',
    'pyramid_xmlrpc',
    ]

setup(name='BCCVL_Visualiser',
      version='0.0',
      description='BCCVL_Visualiser',
      long_description=README + '\n\n' + CHANGES,
      classifiers=[
        "Programming Language :: Python",
        "Framework :: Pyramid",
        "Topic :: Internet :: WWW/HTTP",
        "Topic :: Internet :: WWW/HTTP :: WSGI :: Application",
        ],
      author='',
      author_email='',
      url='',
      keywords='web wsgi bfg pylons pyramid',
      packages=find_packages(),
      include_package_data=True,
      zip_safe=False,
      test_suite='bccvl_visualiser',
      install_requires=requires,
      entry_points="""\
      [paste.app_factory]
      main = bccvl_visualiser:main
      [console_scripts]
      initialize_BCCVL_Visualiser_db = bccvl_visualiser.scripts.initializedb:main
      destroy_BCCVL_Visualiser_db = bccvl_visualiser.scripts.destroydb:main
      """,
      )
