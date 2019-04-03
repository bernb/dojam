#include "loaderwindow.h"
#include "ui_loaderwindow.h"

LoaderWindow::LoaderWindow(QWidget *parent) :
    QWidget(parent)
{
    m_layout = new QGridLayout(this);
    m_appview = new QWebEngineView(this);
    m_dojam_url = QUrl(QStringLiteral("http://localhost:22333"));

    this->setLayout(m_layout);

    m_layout->addWidget(m_appview);
    m_layout->setContentsMargins(0, 0, 0, 0);

    m_appview->setUrl(m_dojam_url);
}
