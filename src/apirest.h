#ifndef APIREST_H
#define APIREST_H

#include <QJsonDocument>
#include <QJsonObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QObject>

#define API_KEY "NWhuTbr99Htq0uJdK4Jj6M8oFbK9OQ1r"

class ApiRest : public QObject {
  Q_OBJECT
  Q_PROPERTY(
      QJsonObject JsonData READ JsonData WRITE setJsonData NOTIFY dataChanged)
  Q_PROPERTY(QJsonObject JsonCityData READ JsonCityData WRITE setJsonCityData
                 NOTIFY cityDataChanged)

public:
  explicit ApiRest(QObject *parent = nullptr);
  QJsonObject JsonData() const;
  void setJsonData(const QJsonObject &data);

  QJsonObject JsonCityData() const;
  void setJsonCityData(const QJsonObject &newJsonCityData);

private:
  QNetworkAccessManager m_NetworkAccessManager;
  QNetworkAccessManager m_NetworkCityAccessManager;

  QJsonObject m_JsonData;
  QJsonObject m_JsonCityData;

  QString m_CityKey;

signals:
  void dataChanged(QJsonObject);

  void cityDataChanged(QJsonObject);

public slots:
  void restApiRequest();
  void restCityApiRequest(const QString &);
  void onRestApiFinished(QNetworkReply *);
  void onRestCityApiFinished(QNetworkReply *);
};

#endif // APIREST_H
