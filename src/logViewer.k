using konoha.qt4.*;

class EventItem 
{
	QGraphicsEllipseItem ellip;
	QGraphicsTextItem text;
	String name;
	QRectF pos;
	QTimer t;
	QBrush b;
	QColor c;
	boolean lightUp;
	boolean working;
	boolean error;
	EventItem(float x, float y, float w, float h) {
		ellip = new QGraphicsEllipseItem();
		text = new QGraphicsTextItem();
		pos = new QRectF();
		pos.setRect(x, y, w, h);
		ellip.setRect(pos);
		name = "";

		b = new QBrush();
		b.setStyle(1);
		c = new QColor();
		c.setRgb(255, 255, 255, 100);
		b.setColor(c);
		ellip.setBrush(b);
		c.setRgb(100, 100, 100, 255);
		b.setColor(c);
		QPen p = new QPen();
		p.setBrush(b);
		p.setWidth(3);
		ellip.setPen(p);

		ellip.addEvent("mouse-press-event", delegate(this, mEvent));
		working = false;
		lightUp = false;
		error = false;
	}

	void mEvent(QGraphicsMouseEvent event) {
		print "hi";
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

class TaskItem 
{
	QGraphicsRectItem rect;
	QGraphicsTextItem text;
	String name;
	QRectF pos;
	QTimer t;
	QBrush b;
	QColor c;
	boolean lightUp;
	boolean working;
	boolean error;
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
		c.setRgb(100, 100, 100, 255);
		b.setColor(c);
		QPen p = new QPen();
		p.setBrush(b);
		p.setWidth(3);
		rect.setPen(p);

		t = new Timer(null);
		rect.addEvent("mouse-press-event", delegate(this, mEvent));
		t.addEvent("timer-event", delegate(this, tEvent));
		t.start(300);
		working = false;
		lightUp = false;
		error = false;
	}

	void mEvent(QGraphicsMouseEvent event) {
		print "hi";
	}

	void tEvent() {
		if (this.working) {
			if (this.lightUp) {
				this.lightUp = false;
				c.setRgb(255, 255, 255, 100);
				b.setColor(c);
				rect.setBrush(b);
			}
			else {
				this.lightUp = true;
				c.setRgb(255, 255, 255, 150);
				b.setColor(c);
				rect.setBrush(b);
			}
		}
		else if (this.error) {
			if (this.lightUp) {
				this.lightUp = false;
				c.setRgb(255, 0, 0, 100);
				b.setColor(c);
				rect.setBrush(b);
			}
			else {
				this.lightUp = true;
				c.setRgb(255, 0, 0, 150);
				b.setColor(c);
				rect.setBrush(b);
			}
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

class GateWayItem 
{
	QGraphicsRectItem rect;
	QGraphicsTextItem text;
	String name;
	QRectF pos;
	QRectF realPos;
	QTimer t;
	QBrush b;
	QColor c;
	boolean rightUp;
	GateWayItem(float x, float y, float w, float h) {
		rect = new QGraphicsRectItem();
		text = new QGraphicsTextItem();
		pos = new QRectF();
		realPos = new QRectF();
		realPos.setRect(x + w / 2, y - h / 2, w, h);
		pos.setRect(x, y, w, h);
		rect.setRect(realPos);
		QPointF p = new QPointF();
		p.setX(x);
		p.setY(y);
		rect.setTransformOriginPoint(p);
		rect.setRotation(45);
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

