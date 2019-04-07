#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::mainwindow),
    m_version(""),
    m_build("")
{
    ui->setupUi(this);
    QDir app_dir(QApplication::applicationDirPath());
    QFile version_file(app_dir.path() + "/version");
    if(!version_file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QMessageBox::information(this,
                                 "Unknown version",
                                 "Warning: Could not read current version from file: " + version_file.errorString());
    } else {
        QTextStream in(&version_file);
        QString line = in.readLine();
        QStringList version_build = line.split('b');
        m_version = version_build.first();
        m_build = version_build.last();
    }
    ui->version->setText(m_version);
    ui->build->setText(m_build);
}

MainWindow::~MainWindow()
{
    delete ui;
}
