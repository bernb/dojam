#ifndef LOADERWINDOW_H
#define LOADERWINDOW_H

#include <QWidget>
#include <QWebEngineView>
#include <QSizePolicy>
#include <QLayout>
#include <QGridLayout>

namespace Ui {
class LoaderWindow;
}

class LoaderWindow : public QWidget
{
    Q_OBJECT

public:
    explicit LoaderWindow(QWidget *parent = nullptr);

private:
    QUrl m_dojam_url;
    QWebEngineView *m_appview;
    QLayout *m_layout;
};

#endif // LOADERWINDOW_H
