import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    Rectangle {
        id: horizontalLine
        height: 2
        width: parent.width
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        border.width: 2
        border.color: "black"
    }

    property real itemScale: 1.5
    property real itemWidth: width / 2
    property real itemHeight: height / 2

    Grid {
        id: grid
        anchors.fill: parent
        anchors.topMargin: 10
        rows: 2
        columns: 2

        // Дні тижня з погодою і температурою
        ItemWeather {
            id: weather1
            width: itemWidth
            height: itemHeight
            dayOfWeek: qsTr("Monday")
            scaleFactor: itemScale
        }
        ItemWeather {
            id: weather2
            width: itemWidth
            height: itemHeight
            dayOfWeek: qsTr("Tuesday")
            scaleFactor: itemScale
        }
        ItemWeather {
            id: weather3
            width: itemWidth
            height: itemHeight
            dayOfWeek: qsTr("Wednesday")
            scaleFactor: itemScale
        }
        ItemWeather {
            id: weather4
            width: itemWidth
            height: itemHeight
            dayOfWeek: qsTr("Thursday")
            scaleFactor: itemScale
        }

        property int minTemp: 0
        property int maxTemp: 0

        Connections {
            target: appBridge

            // Зміна елементів із погодою коли прийде відповідь на запит
            function onDataChanged() {
                //1
                var date = new Date(appBridge.JsonData.DailyForecasts[1].EpochDate * 1000);
                // Локалізація зі Штатів, бо нативна локалізація записує усі слова з маленької без відмінку
                weather1.dayOfWeek = date.toLocaleDateString(Qt.locale("en_US"), "dddd")
                weather1.setIcon(appBridge.JsonData.DailyForecasts[1].Day.Icon);

                // Температура записана у Фаренгейтах, тому перетворюємо її у Цельсій
                minTemp = (appBridge.JsonData.DailyForecasts[1].Temperature.Minimum.Value - 32) * 5 / 9;
                maxTemp = (appBridge.JsonData.DailyForecasts[1].Temperature.Maximum.Value - 32) * 5 / 9;
                weather1.tempMin = minTemp + " °C";
                weather1.tempMax = maxTemp + " °C";

                //2
                date = new Date(appBridge.JsonData.DailyForecasts[2].EpochDate * 1000);
                weather2.dayOfWeek = date.toLocaleDateString(Qt.locale("en_US"), "dddd")
                weather2.setIcon(appBridge.JsonData.DailyForecasts[2].Day.Icon);

                minTemp = (appBridge.JsonData.DailyForecasts[2].Temperature.Minimum.Value - 32) * 5 / 9;
                maxTemp = (appBridge.JsonData.DailyForecasts[2].Temperature.Maximum.Value - 32) * 5 / 9;
                weather2.tempMin = minTemp + " °C";
                weather2.tempMax = maxTemp + " °C";

                //3
                date = new Date(appBridge.JsonData.DailyForecasts[3].EpochDate * 1000);
                weather3.dayOfWeek = date.toLocaleDateString(Qt.locale("en_US"), "dddd")
                weather3.setIcon(appBridge.JsonData.DailyForecasts[3].Day.Icon);

                minTemp = (appBridge.JsonData.DailyForecasts[3].Temperature.Minimum.Value - 32) * 5 / 9;
                maxTemp = (appBridge.JsonData.DailyForecasts[3].Temperature.Maximum.Value - 32) * 5 / 9;
                weather3.tempMin = minTemp + " °C";
                weather3.tempMax = maxTemp + " °C";

                //4
                date = new Date(appBridge.JsonData.DailyForecasts[4].EpochDate * 1000);
                weather4.dayOfWeek = date.toLocaleDateString(Qt.locale("en_US"), "dddd")
                weather4.setIcon(appBridge.JsonData.DailyForecasts[4].Day.Icon);

                minTemp = (appBridge.JsonData.DailyForecasts[4].Temperature.Minimum.Value - 32) * 5 / 9;
                maxTemp = (appBridge.JsonData.DailyForecasts[4].Temperature.Maximum.Value - 32) * 5 / 9;
                weather4.tempMin = minTemp + " °C";
                weather4.tempMax = maxTemp + " °C";
            }
        }
    }
}
