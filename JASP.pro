cache()

include(JASP.pri)

TEMPLATE = subdirs

DESTDIR = .

SUBDIRS += \
	JASP-Common \
        JASP-Engine \
        JASP-Desktop

unix: SUBDIRS += $$JASP_R_INTERFACE_TARGET

JASP-Desktop.depends = JASP-Common
JASP-Engine.depends = JASP-Common

unix: JASP-Engine.depends += $$JASP_R_INTERFACE_TARGET

DISTFILES += \
    Resources/Common/qml/equivalencetest.qml
