using konoha.qt4.*;
using konoha.posix.*;
include "popUpWidget.k";
include "flowParser.k";
include "logParser.k";
include "taskTable.k";

class PaintWidget {

	QWidget paintWidget;
	QGridLayout gridWorkFlowLayout;
	QToolButton taskButton;
	QToolButton monitorButton;
	TaskTable taskTable;
	QIcon eventIcon;
	QIcon taskIcon;
	QIcon gatewayIcon;
	QIcon xORgatewayIcon;
	QIcon aNDgatewayIcon;
	QIcon errorIcon;
	QIcon recoverIcon;
	QIcon monitorIcon;
	QSize iconSize;

	LogParser logParser;
	FlowParser flowParser;
	PopUpWidget popUpWidget;

//	void monitor();

	PaintWidget(){

		_paintWidget = new QWidget();
		//paintWidget.addEvent("timer-event",delegate(this, monitor));
		_gridWorkFlowLayout = new QGridLayout();
		gridWorkFlowLayout.setSpacing(0);

		taskTable = new TaskTable();

		monitorButton = new QToolButton();
		eventIcon = new QIcon();
		taskIcon = new QIcon();
		gatewayIcon = new QIcon();
		xORgatewayIcon = new QIcon();
		aNDgatewayIcon = new QIcon();
		errorIcon = new QIcon();
		recoverIcon = new QIcon();
		monitorIcon = new QIcon();
		iconSize = new QSize();

		eventIcon.addFile("images/eventIcon.png", iconSize, 0, 0);
		taskIcon.addFile("images/taskIcon.png", iconSize, 0, 0);
		gatewayIcon.addFile("images/gatewayIcon.png", iconSize, 0, 0);
		xORgatewayIcon.addFile("images/XORgatewayIcon.png", iconSize, 0, 0);
		aNDgatewayIcon.addFile("images/ANDgatewayIcon.png", iconSize, 0, 0);
		errorIcon.addFile("images/errorIcon.png", iconSize, 0, 0);
		recoverIcon.addFile("images/recoverIcon.png", iconSize, 0, 0);
		monitorIcon.addFile("images/monitorButtonIcon.png", iconSize, 0, 0);

		monitorButton.setIcon(monitorIcon);

		_logParser = new LogParser();
		_flowParser = new FlowParser();
	}

	void workFlowOutput(String fileName){
		InputStream in = new InputStream(fileName);
		String flow;
		int flowline = 0;
		while ((flow = in.readLine()) != null){
			if (flow != null){
				createWorkFlow(flowParser.getTaskType(flow), flowParser.getTaskName(flow), flowParser.getTaskWork(flow), flowParser.getTaskPosX(flow), flowParser.getTaskPosY(flow));
				flowline ++;
				flow = "l:" + flowline + " " + flow;
				print flow;
			}
		}
	}

	void createWorkFlow(String taskType, String taskName, String taskWork, int x, int y){
		taskButton = new QToolButton();
		taskButton.signalConnect("pressed", delegate(this, taskButtonPressed));
		taskButton.setAutoRaise(true);

		if (taskType == "Event"){
			taskButton.setIcon(eventIcon);
		}
		if (taskType == "Task"){
			taskButton.setIcon(taskIcon);
		}
		if (taskType == "Gateway"){
			if (taskName == "AND"){
				taskButton.setIcon(aNDgatewayIcon);
			}
			if (taskName == "XOR"){
				taskButton.setIcon(xORgatewayIcon);
			}
		}
		if (taskType == "Error"){
			taskButton.setIcon(errorIcon);
		}
		if (taskType == "Recover"){
			taskButton.setIcon(recoverIcon);
		}

		taskTable.x.add(x);
		taskTable.y.add(y);
		taskTable.type.add(taskType);
		taskTable.name.add(taskName);
		taskTable.work.add(taskType);

		gridWorkFlowLayout.addWidget(taskButton, y, x, 0);
		paintWidget.setLayout(gridWorkFlowLayout);
	}

	void taskButtonPressed(){
		_popUpWidget = new PopUpWidget();
		popUpWidget.myPopUpShow("sourceCode");
	}

//	void monitor(){
//			//gridWorkFlowLayout.addWidget(monitorButton, task.y[i], task.x[i],0);
//			paintWidget.setLayout(gridWorkFlowLayout);
//	}
};
