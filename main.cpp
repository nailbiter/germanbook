#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDir>
#include <iostream>
#include <QMediaPlayer>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QDir dir("../germanbook/hungerkunstler");
    dir.setFilter(QDir::Files | QDir::Hidden | QDir::NoSymLinks);
    dir.setSorting(QDir::Size | QDir::Reversed);

    QFileInfoList list = dir.entryInfoList();
    std::cout << "     Bytes Filename" << std::endl;
    for (int i = 0; i < list.size(); ++i) {
        QFileInfo fileInfo = list.at(i);
        std::cout << qPrintable(QString("%1 %2").arg(fileInfo.size(), 10)
                                                .arg(fileInfo.fileName()));
        std::cout << std::endl;
    }

    /*QMediaPlayer* player = new QMediaPlayer;
    player->setMedia(QUrl::fromLocalFile("../germanbook/hungerkunstler/sound1.mp3"));
    player->setVolume(50);
    player->play();

    std::cout << "tesime"<<std::endl;*/
    //return 0;

    return app.exec();
}
