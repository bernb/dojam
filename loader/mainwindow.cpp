#include "mainwindow.h"
#include "ui_mainwindow.h"



MainWindow::MainWindow(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::mainwindow),
    m_version(""),
    m_build(""),
    m_check_updates(new QProcess())
{
    ui->setupUi(this);
    setVersion();

    ui->version->setText(m_version);
    ui->build->setText(m_build);

    ui->check_updates->setText("Checking for updates...");
    ui->check_updates->setEnabled(false);

    m_check_updates->start("sleep 3");

    connect(m_check_updates,
            SIGNAL(finished(int, QProcess::ExitStatus)),
            this,
            SLOT(setUpdateStatus(int)));
    connect(ui->start_app,
            SIGNAL(clicked()),
                   this,
            SLOT(start_app()));

}

void MainWindow::setVersion()
{
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
}

void MainWindow::setUpdateStatus(int exitCode) {
    ui->check_updates->setText("No new updates");
}

void MainWindow::start_app() {
    this->app_view = new LoaderWindow();
    this->app_view->showMaximized();
}

MainWindow::~MainWindow()
{
    delete ui;
    delete app_view;
}
