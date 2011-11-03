using konoha.qt4.*;
using konoha.posix.*;
include "paintWidget.k"
include "logParser.k"

class MainWidget {

	int monitor = 0;//on = 1, off = 0
	int monitoringTimerId;

	/* Difinition of widgets */
	QWidget wholeWidget;
	PaintWidget paintWidget;
	QTextEdit textWidget;
	QHBoxLayout workFlowLayout;
	QVBoxLayout wholeLayout;

	/* Difinition of logFileForm components */
	QHBoxLayout fileFormLayout;
	QLabel fileNameLabel;
	QLineEdit fileNameLine;
	QPushButton analyzeButton;
	QPushButton monitorButton;


	void workFlowOutput(PaintWidget paintWidget, String fileName);
	void createPaintWidget();
	void monitorButtonPressed();
	void callMonitor();

	MainWidget(){

		/* whole layout & widget setting */
		_wholeWidget = new QWidget();
		timer = new QTimer(wholeWidget);
		_monitorWidget = new PaintWidget();
		_diagnosisWidget = new PaintWidget();
		_recoverWidget = new PaintWidget();
		paintWidget.paintWidget.addEvent("timer-event", delegate(this, callMonitor));
		textWidget = new QTextEdit();
		logFileFormWidget = new QWidget();
		_wholeLayout = new QVBoxLayout();
		_workFlowLayout = new QHBoxLayout();

		/* log file form setting */
		fileFormLayout = new QHBoxLayout();
		fileNameLabel = new QLabel();
		fileNameLabel.setText("file :");
		_fileNameLine = new QLineEdit();
		fileNameLine.signalConnect("return-pressed", delegate(this, createPaintWidget));
		_analyzeButton = new QPushButton();
		analyzeButton.setText("analyze");
		analyzeButton.signalConnect("pressed", delegate(this, createPaintWidget));
		_monitorButton = new QPushButton();
		monitorButton.setText("monitor");
		monitorButton.signalConnect("pressed", delegate(this, monitorButtonPressed));

		/* add layout & widget */
		//fileFormLayout.addWidget(fileNameLabel);
		//fileFormLayout.addWidget(fileNameLine);
		//fileFormLayout.addWidget(analyzeButton);
		fileFormLayout.addWidget(monitorButton);

		/* setting workflow Layout */
		workFlowLayout.addWidget(monitorWidget.paintWidget);
		workFlowLayout.addWidget(diagnosisWidget.paintWidget);
		workFlowLayout.addWidget(recoverWidget.paintWidget);

		monitorWidget.workFlowOutput("flows/monitorFlow");
		diagnosisWidget.workFlowOutput("flows/diagnosisFlow");
		recoverWidget.workFlowOutput("flows/recoverFlow");

		/* setting wholeLayout */
		wholeLayout.addLayout(fileFormLayout);
		wholeLayout.addLayout(workFlowLayout);
		wholeLayout.addWidget(textWidget);

		wholeWidget.setLayout(wholeLayout);
	}

	void createPaintWidget(){
		//workFlowOutput(fileNameLine.getText());
		//logline = 0;
	}

	void monitorButtonPressed(){
		if (monitor == 0){
			monitor = 1;
			print "monitoring started";
			monitoringTimerId = paintWidget.paintWidget.startTimer(300);
		}
		else if (monitor == 1){
			monitor = 0;
			print "monitoring stopped";
			paintWidget.paintWidget.killTimer(monitoringTimerId);
		}
	}

	void callMonitor(){
	//	paintWidget.monitor();
	}
};

QApplication app = new QApplication();
MainWidget mainWidget = new MainWidget();
mainWidget.wholeWidget.setWindowTitleOL("Fault Detection Monitor");
QRect widgetRect = new QRect();
widgetRect.setRect(100,100,512,512);
mainWidget.wholeWidget.setGeometry(widgetRect);
mainWidget.wholeWidget.show();
app.exec();
