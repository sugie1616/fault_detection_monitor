
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
		c.setRgb(40, 40, 40, 255);
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
	QGraphicsSimpleTextItem text;
	String name;
	QRectF pos;
	QPointF point;
	QTimer t;
	QBrush b;
	QColor c;
	QFont f;
	boolean lightUp;
	boolean working;
	boolean error;
	int sw, sh;
	TaskItem(String n, float x, float y, float w, float h) {
		rect = new QGraphicsRectItem();
		text = new QGraphicsSimpleTextItem();
		pos = new QRectF();
		point = new QPointF();
		f = new QFont();
		name = n;
		f.setFamily("Phetsarath");
		f.setPointSize(14);
		pos.setRect(x, y, w, h);
		//text.setText(name);
		String taskName;
		taskName = getAdjustedText(name, f, w);
		text.setText(taskName);
		point.setX(x + 2);
		point.setY(getAdjustedY(taskName, f, y, h));
		rect.setRect(pos);
		text.setPos(point);
		text.setFont(f);

		b = new QBrush();
		b.setStyle(1);
		c = new QColor();
		c.setRgb(255, 255, 255, 100);
		b.setColor(c);
		rect.setBrush(b);
		c.setRgb(40, 40, 40, 255);
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
	
	String getAdjustedText(String text, QFont f, int w){
		String tmp,str;
		String[] map = [];
		map = text.split("_");
		tmp = map[0];
		str = map[0];
		int mapSize = map.getSize();
		for (int i = 0; i < mapSize - 1; i ++) {
			print tmp.getSize(),map[i + 1].getSize(),f.getPointSize();
			if ((tmp.getSize() + map[i + 1].getSize()) * f.getPointSize() < w) {
				str = str + "_" + map[i + 1];
				tmp = tmp + "_" + map[i + 1];
			}
			else {
				tmp = map[i + 1];
				str = str + "\n" + map[i + 1];
			}
		}
		return str;
	}
	
	int getAdjustedX(String text, QFont f, int x, int w){
	//	String[] map = [];
	//	map = text.split("\n");
	//	int n;
	//	n = map.getSize();
	//	for (int i = 0; i < n; i ++){
	//		
	//	}
	}
	
	int getAdjustedY(String text, QFont f, int y, int h){
		String[] map = [];
		map = text.split("\n");
		int mapSize = map.getSize();
		int textHeight = mapSize * f.getPointSize() * 1.5;
		print mapSize, textHeight;
		if (h > textHeight) {
			return y + (h - textHeight)/2;
		}
		else {
			return y;
		}
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
