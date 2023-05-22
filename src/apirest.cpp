#include "apirest.h"

ApiRest::ApiRest(QObject *parent) : QObject{parent}, m_CityKey("") {
  QObject::connect(&m_NetworkAccessManager, SIGNAL(finished(QNetworkReply *)),
                   this, SLOT(onRestApiFinished(QNetworkReply *)));
  QObject::connect(&m_NetworkCityAccessManager,
                   SIGNAL(finished(QNetworkReply *)), this,
                   SLOT(onRestCityApiFinished(QNetworkReply *)));
}

QJsonObject ApiRest::JsonData() const { return m_JsonData; }

void ApiRest::setJsonData(const QJsonObject &data) {
  m_JsonData = data;
  emit dataChanged(m_JsonData);
}

void ApiRest::restApiRequest() {
  QNetworkRequest request;
  QUrl url("http://dataservice.accuweather.com/forecasts/v1/daily/5day/" +
           m_CityKey + "?apikey=" API_KEY);

  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  request.setUrl(url);
  m_NetworkAccessManager.get(request);
}

void ApiRest::restCityApiRequest(const QString &coordinates) {
  QNetworkRequest request;
  QUrl url("http://dataservice.accuweather.com/locations/v1/cities/geoposition/"
           "search?apikey=" API_KEY "&q=" +
           coordinates);

  request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");
  request.setUrl(url);
  m_NetworkCityAccessManager.get(request);
}

void ApiRest::onRestApiFinished(QNetworkReply *reply) {
  QJsonDocument jsdoc = QJsonDocument::fromJson(reply->readAll());
  setJsonData(jsdoc.object());
  //  QByteArray docByteArray = jsdoc.toJson(QJsonDocument::Compact);
  //  qDebug() << QLatin1String(docByteArray);
}

void ApiRest::onRestCityApiFinished(QNetworkReply *reply) {
  QJsonDocument jsdoc = QJsonDocument::fromJson(reply->readAll());
  setJsonCityData(jsdoc.object());
  //  QByteArray docByteArray = jsdoc.toJson(QJsonDocument::Compact);
  //  qDebug() << QLatin1String(docByteArray);

  m_CityKey = m_JsonCityData.find("Key")->toString();
  //  qDebug() << m_CityKey;
  restApiRequest();
}

QJsonObject ApiRest::JsonCityData() const { return m_JsonCityData; }

void ApiRest::setJsonCityData(const QJsonObject &newJsonCityData) {
  if (m_JsonCityData == newJsonCityData)
    return;
  m_JsonCityData = newJsonCityData;
  emit cityDataChanged(m_JsonCityData);
}
