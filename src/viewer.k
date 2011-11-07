/************************************************************/
/* Copyright (C) 2011 */
/* yoan: Motoki yoan */
/************************************************************/

using konoha.qt4.*;

include "logViewer.k";

EVENT_RADIUS = 30;
TASK_WIDTH   = 100;
TASK_HEIGHT  = 70;

class Viewer
{
	QGraphicsScene scene;
	int view_x;
	int view_y;
	int senario_x;
	Viewer() {
		view_x = 1500;
		view_y = 500;
		senario_x = view_x / 3;
	}

	void initScene(TaskList list)
	{
		int x = 7;
		int y = 5;
		int block_x = senario_x / x;
		int block_y = view_y / y;
		QRectF r_pos = new QRectF();
		foreach (t in list.list) {
			if (t.type == "Event") {
				r_pos.setRect(t.x * block_x + block_x / 2 - EVENT_RADIUS / 2, 
						t.y * block_y + block_y / 2 - EVENT_RADIUS / 2, 
						EVENT_RADIUS, EVENT_RADIUS);
				QGraphicsEllipseItem e = new QGraphicsEllipseItem();
				e.setRect(r_pos);
				scene.addItem(e);
			}
			else if (t.type == "Task") {
				TaskItem item = new TaskItem(t.x * block_x + block_x / 2 - TASK_WIDTH / 2,
						t.y * block_y + block_y / 2 - TASK_HEIGHT / 2,
					   	TASK_WIDTH, TASK_HEIGHT);
				scene.addItem(item.rect);
			}
			else {
			}
		}
	}
	
	void parseFlow(TaskList list) {
		app = new QApplication();
		scene = new QGraphicsScene();
		rect = new QRectF();
		rect.setRect(0, 0, view_x, view_y);
	
		scene.setSceneRect(rect);
		b = new QBrush();
		b.setStyle(1);
		c = new QColor();
		c.setRgb(38, 61, 51, 255);
		b.setColor(c);
		scene.setBackgroundBrush(b);
		this.initScene(list);
		view = new QGraphicsView();
		view.setScene(scene);
		view.show();
		app.exec();
	}
}

/*
void main()
{
	Task event = new Task();
	TaskList taskList = new TaskList();

	event.x = 100;
	event.y = 100;
	event.type = "Event";
	event.name = "start";

	Task task1 = new Task();
	task1.x = 200;
	task1.y = 100;
	task1.type = "Task";
	task1.name = "task";

	Task task2 = new Task();
	task2.x = 400;
	task2.y = 100;
	task2.type = "Task";
	task2.name = "task";

	taskList.add(event);
	taskList.add(task1);
	taskList.add(task2);

	v = new Viewer();
	v.parseFlow(taskList);
}
*/
