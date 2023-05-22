import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: weather
    color: 'white'

    // Теперішній час і дата
    ColumnLayout {
        id: column
        anchors{
            left: parent.left
            top: parent.top
            right: parent.right
        }
        spacing: 0
        height: parent.height / 5
        Text {
            id: time
            font.pixelSize: 90
            Layout.alignment: Qt.AlignHCenter
            text: "00:00:00"
        }
        Text {
            id: date
            font.pixelSize: 35
            Layout.alignment: Qt.AlignHCenter
            text: "---- -- ---"
        }
    }

    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            var _date = new Date();
            time.text = Qt.formatDateTime(_date, "hh:mm:ss")
            date.text = _date.toLocaleDateString(Qt.locale("en_US"), "dddd dd MMMM")
        }
    }

    // Погода сьогодні
    ItemWeather {
        id: weather0
        height: (parent.height - column.height) / 2.25
        width: parent.width
        anchors{
            top: column.bottom
            horizontalCenter: parent.horizontalCenter
        }
        scaleFactor: 3
    }

    // Погода на наступні 4 дня тижня
    DaysWeather{
        height: parent.height - column.height - weather0.height
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            margins: 10
            left: parent.left
        }
    }

    property int minTemp: 0
    property int maxTemp: 0

    Connections {
        target: appBridge

        function onDataChanged() {
            // Зміна сьогоднішньої погоди
            weather0.setIcon(appBridge.JsonData.DailyForecasts[0].Day.Icon)
            minTemp = (appBridge.JsonData.DailyForecasts[0].Temperature.Minimum.Value - 32) * 5 / 9
            maxTemp = (appBridge.JsonData.DailyForecasts[0].Temperature.Maximum.Value - 32) * 5 / 9
            weather0.tempMin = minTemp + " °C"
            weather0.tempMax = maxTemp + " °C"
        }

        function onCityDataChanged() {
            // Зміна назви населеного пункту, в якому показується погода
            weather0.dayOfWeek = appBridge.JsonCityData.LocalizedName;
        }
    }
}
