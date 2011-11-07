
using konoha.qt4.*;

void clicked(QGraphicsScene scene, QGraphicsSceneMouseEvent event) {
	print "clicked";
	print event.scenePos().x;
	print event.scenePos().y;
}

class TaskItem 
{
	QGraphicsRectItem rect;
	QGraphicsTextItem text;
	String name;
	QRectF pos;
	QTimer t;
	QBrush b;
	QColor c;
	boolean rightUp;
	TaskItem(float x, float y, float w, float h) {
		rect = new QGraphicsRectItem();
		text = new QGraphicsTextItem();
		pos = new QRectF();
		pos.setRect(x, y, w, h);
		rect.setRect(pos);
		name = "";

		b = new QBrush();
		b.setStyle(1);
		c = new QColor();
		c.setRgb(255, 255, 255, 100);
		b.setColor(c);
		rect.setBrush(b);

		//t = new Timer(null);
		//rect.addEvent("mouse-press-event", clicked);
		//t.addEvent("timer-event", delegate(this, workingEvent));
		//t.start(1000);
		rightUp = false;
	}

	void workingEvent() {
		if (this.rightUp) {
			this.rightUp = false;
			c.setRgb(255, 255, 255, 100);
			b.setColor(c);
			rect.setBrush(b);
		}
		else {
			this.rightUp = true;
			c.setRgb(255, 255, 255, 150);
			b.setColor(c);
			rect.setBrush(b);
		}
	}

	QGraphicsLineItem jointFromEnd(QRectF r) {
		QLineF line = new QLineF();
		line.setLine(pos.getX(), pos.getY() + pos.getHeight() / 2, r.getX() + r.getWidth(), r.getY() + r.getHeight() / 2);
		QGraphicsLineItem ret = new QGraphicsLineItem();
		ret.setLine(line);
		return ret;
	}

	QGraphicsLineItem jointFromStart(QRectF r) {
		QLineF line = new QLineF();
		line.setLine(pos.getX() + pos.getWidth(), pos.getY() + pos.getHeight() / 2, r.getX(), r.getY() + r.getHeight() / 2);
		QGraphicsLineItem ret = new QGraphicsLineItem();
		ret.setLine(line);
		return ret;
	}
}
