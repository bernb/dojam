#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QWidget>
#include <QFile>
#include <QMessageBox>
#include <QTextStream>
#include <QApplication>
#include <QDir>
#include<QDebug>

namespace Ui {
class mainwindow;
}

class MainWindow : public QWidget
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private:
    Ui::mainwindow *ui;
    QString m_version;
    QString m_build;
};

#endif // MAINWINDOW_H
