import QtQuick 2.15
import QtQuick.Window 2.15
import ApiRest 1.0
import "ui/Map"
import "ui/Weather"

Window {
    minimumWidth: 1100
    width: 1280
    minimumHeight: 640
    height: 720
    visible: true
    title: qsTr("Forecast Map")

    // Ліва частина екрану із погодою
    Weather {
        id: weather
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: parent.width / 3
    }

    // Права частина погоди із картою
    MyMap {
        id: map
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
            left: weather.right
        }
    }

    // Об'єкт класу, який виконує network запроси і отримує відповіді
    ApiRest {
        id: appBridge
    }

}
