/************************************************************/
/* Copyright (C) 2011 */
/* yoan: Motoki yoan */
/************************************************************/

using konoha.qt4.*;

include "logViewer.k";

class Viewer
{
	QGraphicsScene scene;

	void initScene(TaskList list)
	{
		QRectF r_pos = new QRectF();
		foreach (t in list.taskList) {
			if (t.type == "Event") {
				r_pos.setRect(t.x, t.y, 30, 30);
				QGraphicsEllipseItem e = new QGraphicsEllipseItem();
				e.setRect(r_pos);
				scene.addItem(e);
			}
			else if (t.type == "Task") {
				TaskItem item = new TaskItem(t.x, t.y, 150, 70);
				scene.addItem(item.rect);
			}
		}
	}
		///* Monitor Senario Setting */
		//TaskItem mt1 = new TaskItem(200, 50, 150, 70);
		////mt1.setName("Monitor\ntask");
		//TaskItem mt2 = new TaskItem(200, 150, 150, 70);
		////mt2.rect.setRect(pos);
		//TaskItem mt3 = new TaskItem(200, 250, 150, 70);
		////mt3.setName("Monitor\ntask");
		//TaskItem mt4 = new TaskItem(200, 350, 150, 70);
		////mt4.setName("Monitor\ntask");
	
		//pos = new QRectF();
		//pos.setRect(100, 225, 30, 30);
		//QGraphicsEllipseItem mse = new  QGraphicsEllipseItem();
		//mse.setRect(pos);
		//pos.setRect(420, 70, 30, 30);
		//QGraphicsEllipseItem mee1 = new QGraphicsEllipseItem();
		//mee1.setRect(pos);
		//pos.setRect(420, 170, 30, 30);
		//QGraphicsEllipseItem mee2 = new QGraphicsEllipseItem();
		//mee2.setRect(pos);
		//pos.setRect(420, 270, 30, 30);
		//QGraphicsEllipseItem mee3 = new QGraphicsEllipseItem();
		//mee3.setRect(pos);
		//pos.setRect(420, 370, 30, 30);
		//QGraphicsEllipseItem mee4 = new QGraphicsEllipseItem();
		//mee4.setRect(pos);
	
		//scene.addItem(mt1.jointFromEnd(mse.getRect()));
		//scene.addItem(mt2.jointFromEnd(mse.getRect()));
		//scene.addItem(mt3.jointFromEnd(mse.getRect()));
		//scene.addItem(mt4.jointFromEnd(mse.getRect()));
	
		//scene.addItem(mt1.jointFromStart(mee1.getRect()));
		//scene.addItem(mt2.jointFromStart(mee2.getRect()));
		//scene.addItem(mt3.jointFromStart(mee3.getRect()));
		//scene.addItem(mt4.jointFromStart(mee4.getRect()));
	
		//scene.addItem(mt1.rect);
		//scene.addItem(mt2.rect);
		//scene.addItem(mt3.rect);
		//scene.addItem(mt4.rect);
		//scene.addItem(mse);
		//scene.addItem(mee1);
		//scene.addItem(mee2);
		//scene.addItem(mee3);
		//scene.addItem(mee4);
	
		///* Analizer Senario Setting */
		//TaskItem at1 = new TaskItem(600, 50, 150 ,70);
		////mt1.setName("Monitor\ntask");
		//TaskItem at2 = new TaskItem(600 ,150, 150, 70);
		////mt2.setName("Monitor\ntask");
		//TaskItem at3 = new TaskItem(600, 250, 150, 70);
		////mt3.setName("Monitor\ntask");
		//TaskItem at4 = new TaskItem(600, 350, 150, 70);
		////mt4.setName("Monitor\ntask");
	
		//pos.setRect(500, 70, 30, 30);
		//QGraphicsEllipseItem ase1 = new  QGraphicsEllipseItem();
		//ase1.setRect(pos);
		//pos.setRect(500, 170, 30, 30);
		//QGraphicsEllipseItem ase2 = new  QGraphicsEllipseItem();
		//ase2.setRect(pos);
		//pos.setRect(500, 270, 30, 30);
		//QGraphicsEllipseItem ase3 = new  QGraphicsEllipseItem();
		//ase3.setRect(pos);
		//pos.setRect(500, 370, 30, 30);
		//QGraphicsEllipseItem ase4 = new  QGraphicsEllipseItem();
		//ase4.setRect(pos);
		//pos.setRect(820, 70, 30, 30);
		//QGraphicsEllipseItem aee1 = new QGraphicsEllipseItem();
		//aee1.setRect(pos);
		//pos.setRect(820, 170, 30, 30);
		//QGraphicsEllipseItem aee2 = new QGraphicsEllipseItem();
		//aee2.setRect(pos);
		//pos.setRect(820, 270, 30, 30);
		//QGraphicsEllipseItem aee3 = new QGraphicsEllipseItem();
		//aee3.setRect(pos);
		//pos.setRect(820, 370, 30, 30);
		//QGraphicsEllipseItem aee4 = new QGraphicsEllipseItem();
		//aee4.setRect(pos);
	
		//scene.addItem(at1.jointFromEnd(ase1.getRect()));
		//scene.addItem(at2.jointFromEnd(ase2.getRect()));
		//scene.addItem(at3.jointFromEnd(ase3.getRect()));
		//scene.addItem(at4.jointFromEnd(ase4.getRect()));
	
		//scene.addItem(at1.jointFromStart(aee1.getRect()));
		//scene.addItem(at2.jointFromStart(aee2.getRect()));
		//scene.addItem(at3.jointFromStart(aee3.getRect()));
		//scene.addItem(at4.jointFromStart(aee4.getRect()));
	
		//scene.addItem(at1.rect);
		//scene.addItem(at2.rect);
		//scene.addItem(at3.rect);
		//scene.addItem(at4.rect);
	
		//scene.addItem(ase1);
		//scene.addItem(ase2);
		//scene.addItem(ase3);
		//scene.addItem(ase4);
		//scene.addItem(aee1);
		//scene.addItem(aee2);
		//scene.addItem(aee3);
		//scene.addItem(aee4);
	
		///* Recovery Senario Setting */
		//TaskItem rt1 = new TaskItem(1000, 50, 150, 70);
		////mt1.setName("Monitor\ntask");
		//TaskItem rt2 = new TaskItem(1000, 150, 150, 70);
		////mt4.setName("Monitor\ntask");
		//TaskItem rt3 = new TaskItem(1000, 250, 150, 70);
		////mt3.setName("Monitor\ntask");
		//TaskItem rt4 = new TaskItem(1000, 350, 150, 70);
		////mt4.setName("Monitor\ntask");
	
		//pos.setRect(900, 70, 30, 30);
		//QGraphicsEllipseItem rse1 = new  QGraphicsEllipseItem();
		//rse1.setRect(pos);
		//pos.setRect(900, 170, 30, 30);
		//QGraphicsEllipseItem rse2 = new  QGraphicsEllipseItem();
		//rse2.setRect(pos);
		//pos.setRect(900, 270, 30, 30);
		//QGraphicsEllipseItem rse3 = new  QGraphicsEllipseItem();
		//rse3.setRect(pos);
		//pos.setRect(900, 370, 30, 30);
		//QGraphicsEllipseItem rse4 = new  QGraphicsEllipseItem();
		//rse4.setRect(pos);
		//pos.setRect(1220, 70, 30, 30);
		//QGraphicsEllipseItem ree1 = new QGraphicsEllipseItem();
		//ree1.setRect(pos);
		//pos.setRect(1220, 170, 30, 30);
		//QGraphicsEllipseItem ree2 = new QGraphicsEllipseItem();
		//ree2.setRect(pos);
		//pos.setRect(1220, 270, 30, 30);
		//QGraphicsEllipseItem ree3 = new QGraphicsEllipseItem();
		//ree3.setRect(pos);
		//pos.setRect(1220, 370, 30, 30);
		//QGraphicsEllipseItem ree4 = new QGraphicsEllipseItem();
		//ree4.setRect(pos);
	
		//scene.addItem(rt1.jointFromEnd(rse1.getRect()));
		//scene.addItem(rt2.jointFromEnd(rse2.getRect()));
		//scene.addItem(rt3.jointFromEnd(rse3.getRect()));
		//scene.addItem(rt4.jointFromEnd(rse4.getRect()));
	
		//scene.addItem(rt1.jointFromStart(ree1.getRect()));
		//scene.addItem(rt2.jointFromStart(ree2.getRect()));
		//scene.addItem(rt3.jointFromStart(ree3.getRect()));
		//scene.addItem(rt4.jointFromStart(ree4.getRect()));
	
	
		//scene.addItem(rt1.rect);
		//scene.addItem(rt2.rect);
		//scene.addItem(rt3.rect);
		//scene.addItem(rt4.rect);
	
		//scene.addItem(rse1);
		//scene.addItem(rse2);
		//scene.addItem(rse3);
		//scene.addItem(rse4);
		//scene.addItem(ree1);
		//scene.addItem(ree2);
		//scene.addItem(ree3);
		//scene.addItem(ree4);
	
	void parseFlow(TaskList list) {
		app = new QApplication();
		scene = new QGraphicsScene();
		rect = new QRectF();
		rect.setRect(0, 0, 1500, 500);
	
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
