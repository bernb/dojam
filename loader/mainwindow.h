#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QWidget>
#include <QFile>
#include <QMessageBox>
#include <QTextStream>
#include <QApplication>
#include <QDir>
#include <QDebug>
#include <QProcess>
#include "loaderwindow.h"

namespace Ui {
class mainwindow;
}

class MainWindow : public QWidget
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
public slots:
    void setUpdateStatus(int exitCode);
    void start_app();

private:
    Ui::mainwindow *ui;
    QString m_version;
    QString m_build;
    QProcess *m_check_updates;
    LoaderWindow *app_view;
    void setVersion();
};

#endif // MAINWINDOW_H
