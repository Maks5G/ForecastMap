import QtQuick 2.15

Rectangle {
    property string dayOfWeek: " "
    property string tempMin: "--.- °C"
    property string tempMax: "--.- °C"
    property real scaleFactor: 1.0

    color: "transparent"

    function setIcon(value){
        imgWeather.source = "qrc:/ui/assets/" + value + "-s.png";
    }

    // День тижня
    Text {
        id: txtDayOfWeek
        text: dayOfWeek
        anchors{
            horizontalCenter: parent.horizontalCenter
            bottom: imgWeather.top
            bottomMargin: 15 * scaleFactor
        }
        font.pointSize: 15
    }

    // Зображення відповідної погоди
    Image {
        id: imgWeather
        anchors.centerIn: parent
        anchors.top: parent.top
        fillMode: Image.PreserveAspectFit
        source: "qrc:/ui/assets/1-s.png"
        scale: scaleFactor
    }

    // Мінімальна і максимальна температура за день
    Rectangle {
        id: rectTemperatures
        height: 25
        width: parent.width
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: imgWeather.bottom
            topMargin: 15 * scaleFactor
        }
        color: "transparent"

        Text {
            id: txtTempMin
            anchors {
                right: parent.horizontalCenter
                rightMargin: 15
                verticalCenter: parent.verticalCenter
            }
            color: "#3ecdfd"
            font.pointSize: 13 * scaleFactor / 2.5
            text: tempMin
        }

        Text {
            id: txtTempMax
            anchors {
                left: parent.horizontalCenter
                leftMargin: 15
                verticalCenter: parent.verticalCenter
            }
            color: "#fb5255"
            font.pointSize: 13 * scaleFactor / 2.5
            text: tempMax
        }
    }
}
