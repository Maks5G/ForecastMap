import QtQuick 2.15
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Controls 2.15

Rectangle {
    id: mapRect

    Plugin {
        id: mapPlugin
        name: "osm"
    }

    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(49.59373, 34.54073) // Полтава
        zoomLevel: 14

        // Маркер, який для зручності буде відображатися при натиснені на карту
        MapQuickItem {
            id: marker
            anchorPoint.x: image.width/2
            anchorPoint.y: image.height

            sourceItem: Image {
                id: image
                source: "qrc:/ui/assets/marker.png"
            }
        }

        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true
            property var coordinate: map.toCoordinate(Qt.point(mouseX, mouseY))
            onClicked: {
                marker.coordinate = coordinate
                var txt = coordinate.latitude + ", " + coordinate.longitude;
                // Запит для отримання ключа міста по координатам із послідовним запитом на погоду на 5 днів
                appBridge.restCityApiRequest(txt);
            }
        }
    }
}
