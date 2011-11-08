/************************************************************/
/* Copyright (C) 2011 */
/* yoan: Motoki yoan */
/************************************************************/

using konoha.qt4.*;
using konoha.posix.*;

include "logViewer.k";
//include "task.k";

EVENT_RADIUS  = 30;
GATEWAY_WIDTH = 30;
TASK_WIDTH    = 140;
TASK_HEIGHT   = 70;

class Viewer
{
	QGraphicsScene scene;
	int view_x;
	int view_y;
	int senario_x;
	Map taskmap;
	Viewer() {
		view_x = 1500;
		view_y = 500;
		senario_x = view_x / 3;
		taskmap = {};
	}

	void initScene(TaskList list)
	{
		int x = 3;
		int y = 5;
		//int x = list.maxX;
		//int y = list.maxY;
		int block_x = senario_x / x;
		int block_y = view_y / y;
		foreach (t in list.list) {
			if (t.type == "Event") {
				EventItem item = new EventItem (t.x * block_x + block_x / 2 - EVENT_RADIUS / 2,
						t.y * block_y + block_y / 2 - EVENT_RADIUS / 2,
						EVENT_RADIUS, EVENT_RADIUS);
				scene.addItem(item.ellip);
			}
			else if (t.type == "Task") {
				TaskItem item = new TaskItem (t.x * block_x + block_x / 2 - TASK_WIDTH / 2,
						t.y * block_y + block_y / 2 - TASK_HEIGHT / 2,
						TASK_WIDTH, TASK_HEIGHT);
				scene.addItem(item.rect);
				taskmap.set(t.name, item);
				//print taskmap;
			}
			else if (t.type == "Gateway") {
				GateWayItem item = new GateWayItem (t.x * block_x + block_x / 2 - GATEWAY_WIDTH / 2,
						t.y * block_y + block_y / 2 - GATEWAY_WIDTH / 2,
						GATEWAY_WIDTH, GATEWAY_WIDTH);
				scene.addItem(item.rect);
			}
			//else if (t.type == "SequenceFlow") {
			//	GateWayItem item = new GateWayItem(t.x * block_x + block_x / 2 - GATEWAY_WIDTH / 2,
			//			t.y * block_y + block_y / 2 - GATEWAY_WIDTH / 2,
			//			GATEWAY_WIDTH, GATEWAY_WIDTH);
			//	scene.addItem(item.rect);
			//}
			else {
			}
		}
	}
	void flash(Task task) {
		if (taskmap.getSize() == 0) {
			return;
		}
		TaskItem item = taskmap.get(task.name);
		if (task.status == TASK_WORKING) {
			item.working = true;
		}
		else {
			item.error = true;
		}
	}
	
	void visualizeFlow(TaskList list) {
		scene = new QGraphicsScene();
		w = new QWidget();
		QSize size = new QSize();
		size.setWidth(view_x);
		size.setHeight(view_y);
		w.resize(size);
		w.setWindowOpacity(0.07);
		rect = new QRectF();
		rect.setRect(0, 0, view_x, view_y);
	
		scene.setSceneRect(rect);
		scene.addWidget(w);
		b = new QBrush();
		b.setStyle(1);
		c = new QColor();
		c.setRgb(0, 0, 0, 255);
		//c.setRgb(38, 61, 51, 255);
		b.setColor(c);
		scene.setBackgroundBrush(b);
		this.initScene(list);
		view = new QGraphicsView();
		view.setScene(scene);
		view.setWindowOpacity(0.9);
		view.show();
	}
}

//void main()
//{
//	app = new QApplication();
//	Task event = new Task();
//	TaskList taskList = new TaskList();
//
//	event.x = 1;
//	event.y = 1;
//	event.type = "Event";
//	event.name = "start";
//
//	Task task1 = new Task();
//	task1.x = 4;
//	task1.y = 1;
//	task1.type = "Task";
//	task1.name = "task1";
//
//	Task task2 = new Task();
//	task2.x = 7;
//	task2.y = 1;
//	task2.type = "Task";
//	task2.name = "task2";
//
//	taskList.add(event);
//	taskList.add(task1);
//	taskList.add(task2);
//
//
//	v = new Viewer();
//	v.parseFlow(taskList);
//	System.sleep(3);
//	v.flash(task1, 0);
//	System.sleep(3);
//	v.flash(task2, 1);
//	app.exec();
//}
