/************************************************************/
/* Copyright (C) 2011 */
/* yoan: Motoki yoan */
/************************************************************/

using konoha.qt4.*;
using konoha.posix.*;

include "logViewer.k";

class Viewer
{
	QGraphicsScene scene;
	QGraphicsView view;
	int view_x, view_y;
	int real_x, real_y;
	int senario_x;
	int last_x;
	Map taskmap;
	TaskGroup[] g;
	Viewer() {
		real_x = 2000;
		real_y = 700;
		view_x = 2000;
		view_y = 400;
		senario_x = view_x / 3;
		taskmap = {};
	}

	void start() {
		scene = new QGraphicsScene();
		rect = new QRectF();
		rect.setRect(0, 0, real_x, real_y);
	
		scene.setSceneRect(rect);
		//b = new QBrush();
		//b.setStyle(1);
		//c = new QColor();
		//c.setRgb(0, 0, 0, 255);
		//b.setColor(c);
		//c.setRgb(18, 31, 21, 255);
		//scene.setBackgroundBrush(b);

		QLinearGradient grad = new QLinearGradient();
		start = new QPointF();
		start.setX(0);
		start.setY(0);
		end = new QPointF();
		end.setX(0);
		end.setY(real_y);
		grad.setStart(start);
		grad.setFinalStop(end);
		print grad.getStart();
		print grad.getFinalStop();
		c1 = new QColor();
		c1.setRgb(12, 114, 135, 195);
		grad.setColorAt(1.0, c1);
		c2 = new QColor();
		c2.setRgb(0, 0, 0, 255);
		grad.setColorAt(0.4, c2);
		grad.setSpread(QGradient.PadSpread);
		scene.setBackgroundGradientBrush(grad);
	}

	void end() {
		view = new QGraphicsView();
		view.setScene(scene);
		view.setWindowOpacity(0.9);
		view.show();
	}

	void visualizeFlow(TaskList list)
	{
		int block_x;
		int block_y;

		TaskGroup grp;
		TaskList flowlist = new TaskList();
		if (list.name == "monitorFlow") {
			grp = new TaskGroup(list, 0, 100, 500, view_y);
		}
		else if (list.name == "diagnosisFlow") {
			grp = new TaskGroup(list, 450, 100, 650, view_y);
			//senario_x = 1200;
		}
		else if (list.name == "recoverFlow") {
			grp = new TaskGroup(list, 1200, 100, 400, view_y);
			//senario_x = 700;
		}
		this.g.add(grp);
		foreach (t in list.list) {
			if (t.type == "Setting") {
				grp.layoutHint(t.x, t.y);
				block_x = senario_x / t.x;
				block_y = view_y / t.y;
			}
			if (t.type == "Event") {
				grp.addEventItem(scene, t);
			}
			else if (t.type == "Task") {
				item = grp.addTaskItem(scene, t);
				taskmap.set(t.name, item);
				print list.name, item.pos.getX();
			}
			else if (t.type == "Gateway") {
				grp.addGateWayItem(scene, t);
			}
			else if (t.type == "SequenceFlow") {
				flowlist.add(t);
			}
		}
		foreach (f in flowlist.list) {
			grp.addSequenceFlowItem(scene, list, f);
		}
	}
	void flash(Task task) {
		if (taskmap.getSize() == 0) {
			return;
		}
		if (taskmap.get(task.name) != null) {
			TaskItem item = taskmap.get(task.name);
			if (task.status == TASK_WORKING) {
				item.working = true;
			}
			else {
				item.error = true;
			}
		}
	}
	
	//void visualizeFlow(TaskList list) {
	//	this.initScene(list);
	//}
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
