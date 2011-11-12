using konoha.qt4.*;
using konoha.math.*;

EVENT_RADIUS  = 50;
GATEWAY_WIDTH = 30;
TASK_WIDTH    = 100;
TASK_HEIGHT   = 50;

class EventItem 
{
	QGraphicsEllipseItem ellip;
	QGraphicsEllipseItem inEllip;
	QGraphicsTextItem text;
	String name;
	QRectF pos;
	QRectF inPos;
	QTimer t;
	QBrush b;
	QColor c;
	boolean lightUp;
	boolean working;
	boolean error;
	QTimer t;
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
		c.setRgb(120, 120, 120, 255);
		b.setColor(c);
		ellip.setBrush(b);
		c.setRgb(40, 40, 40, 255);
		b.setColor(c);
		QPen p = new QPen();
		p.setBrush(b);
		p.setWidth(3);
		ellip.setPen(p);

		//ellip.addEvent("mouse-press-event", delegate(this, mEvent));
		t.addEvent("timer-event", delegate(this, tEvent));
		working = false;
		lightUp = false;
		error = false;
	}

	void mEvent(QGraphicsMouseEvent event) {
		print "hi";
	}

	void tEvent() {
		if (this.error) {
			if (this.lightUp) {
				this.lightUp = false;
				c.setRgb(255, 0, 0, 100);
				b.setColor(c);
				ellip.setBrush(b);
				inEllip.setBrush(b);
			}
			else {
				this.lightUp = true;
				c.setRgb(255, 0, 0, 240);
				b.setColor(c);
				ellip.setBrush(b);
				inEllip.setBrush(b);
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

class TaskItem 
{
	int sw, sh, px, py, cx, cy, cc;
	int i = 0, j;
	String taskName;
	boolean lightUp;
	boolean circuitSpin;
	boolean working;
	boolean error;
	QTimer t;
	TaskItem[] next;

	QGraphicsRectItem rectItem;
	QPointF rectPoint;
	QRectF rectPos;
	QBrush rectBrush;
	QColor rectColor;
	QPen rectPen;

	QGraphicsSimpleTextItem textItem;
	QPointF textPoint;
	QBrush textBrush;
	QColor textColor;
	QFont textFont;
	
	QGraphicsSimpleTextItem statusText;
	QPointF statusPoint;
	QBrush statusBrush;
	QColor statusColor;
	QFont statusFont;

	QGraphicsPathItem circuitPathItem;
	QPainterPath circuitPath;
	QPointF circuitPoint;
	QBrush circuitBrush;
	QColor circuitColor;
	QPen circuitPen;
	QTimer circuitTime;

	TaskItem(String n, float x, float y, float w, float h) {
		rectItem = createRectItem(x, y, w, h);
		textItem = createTextItem(n, x, y, w, h);
		//statusText = createStatusTextItem(x, y);
		circuitPathItem = createCircuitPathItem(x, y);

		t = new Timer(null);
		t.addEvent("timer-event", delegate(this, tEvent));
		t.start(300);
		working = false;
		lightUp = false;
		error = false;
	}
	
	QGraphicsRectItem createRectItem(float x, float y, float w, float h) {
		rectItem = new QGraphicsRectItem();
		rectPos = new QRectF();
		rectBrush = new QBrush();
		rectColor = new QColor();
		rectPen = new QPen();
		rectPos.setRect(x, y, w, h);
		rectItem.setRect(rectPos);
		rectBrush.setStyle(1);
		rectColor.setRgb(0, 0, 0, 255);
		rectBrush.setColor(rectColor);
		rectItem.setBrush(rectBrush);
		rectColor.setRgb(40, 40, 40, 255);
		rectBrush.setColor(rectColor);
		rectPen.setBrush(rectBrush);
		rectPen.setWidth(3);
		rectItem.setPen(rectPen);
		rectItem.addEvent("mouse-press-event", delegate(this, mEvent));

		return rectItem;
	}
	
	QGraphicsSimpleTextItem createTextItem(String n, float x, float y, float w, float h) {
		textItem = new QGraphicsSimpleTextItem();
		textPoint = new QPointF();
		textBrush = new QBrush();
		textColor = new QColor();
		textFont = new QFont();

		textBrush.setStyle(1);
		//textColor.setRgb(0, 0, 0, 150);
		textColor.setRgb(255, 255, 0, 150);
		textBrush.setColor(textColor);
		textFont.setFamily("Phetsarath");
		textFont.setPixelSize(16);
		//taskName = getAdjustedText(n, textFont, w);
		if (n.startswith("d-task")) {
			n = n["d-task_monitor_".size to -1];
		}
		taskName = n.replace("_", " ");
		textPoint.setX(getAdjustedX(taskName, textFont, x, w));
		textPoint.setY(getAdjustedY(taskName, textFont, y, h));
		textItem.setText(taskName);
		textItem.setBrush(textBrush);
		textItem.setPos(textPoint);
		textItem.setFont(textFont);
		
		return textItem;
	}
	
	QGraphicsSimpleTextItem createStatusTextItem(float x, float y) {
		statusText = new QGraphicsSimpleTextItem();
		statusPoint = new QPointF();
		statusBrush = new QBrush();
		statusColor = new QColor();
		statusFont = new QFont();

		statusBrush.setStyle(1);
		statusColor.setRgb(40, 40, 40, 150);
		//statusColor.setRgb(255, 255, 0, 150);
		statusBrush.setColor(statusColor);
		statusPoint.setX(x);
		statusPoint.setY(y - 27);
		statusFont.setFamily("Phetsarath");
		statusFont.setPixelSize(20);
		//statusFont.setItalic(true);
		statusText.setBrush(statusBrush);
		statusText.setPos(statusPoint);
		statusText.setFont(statusFont);
		statusText.setText("");
		
		return statusText;
	}
	
	QGraphicsPathItem createCircuitPathItem(int x, int y){
		px = x;
		py = y;
		cx = x;
		cy = y;
		cc = 0;
		circuitSpin = false;
		circuitPathItem = new QGraphicsPathItem();
		circuitPath = new QPainterPath();
		circuitPoint = new QPointF();
		circuitBrush = new QBrush();
		circuitColor = new QColor();
		circuitPen = new QPen();
		circuitBrush.setStyle(1);
		circuitColor.setRgb(40, 40, 40, 255);
		circuitBrush.setColor(circuitColor);
		circuitPen.setBrush(circuitBrush);
		circuitPen.setWidth(3);
		circuitPen.setCapStyle(1);

		circuitPoint.setX(x);
		circuitPoint.setY(y);
		circuitPath.moveTo(circuitPoint);

		circuitPathItem.setPen(circuitPen);
		circuitPathItem.setPath(circuitPath);

		circuitTime = new Timer(null);
		circuitTime.addEvent("timer-event", delegate(this, spinCircuitEvent));

		return circuitPathItem;
	}
	

	String getAdjustedText(String text, QFont f, float w) {
		String tmp, str, str2;
		String[] map = [];
		String[] map2 = [];
		map = text.split("_");
		tmp = map[0];
		str = map[0];
		int i, j, k, maxSize, mapSize, mapSize2, tmpSize;
		mapSize = map.getSize();
		//--- adjust number of letter in one line ---//
		for (i = 1; i < mapSize; i ++) {
			if ((tmp.getSize() + map[i].getSize()) * f.getPixelSize() < w * 1.10) {
				if (tmp != ""){
					tmp = tmp + " " + map[i];
					str = str + " " + map[i];
				}
				else {
					tmp = tmp + map[i];
					str = str + map[i];
				}
			}
			else {
				tmp = tmp + map[i];
				if (maxSize < tmp.getSize()){
					maxSize = tmp.getSize();
				}
				tmp = "";
				str = str + " " +  map[i] + "\n";
			}
		}
		map2 = str.split("\n");
		//print "part1 " + str, map2;
		mapSize2 = map2.getSize();
		for (i = 0; i < mapSize2; i ++) {
			if (map2[i] == "") {
				map2.remove(i);
				mapSize2 = map2.getSize();
			}
		}
		//print "part2 " + str, map2;
		for (i = 0; i < mapSize2; i ++) {
			if ((tmpSize = map2[i].getSize()) < maxSize){
				for (j = 0; j < (maxSize - tmpSize) / 2; j ++) {
					map2[i] = " " + map2[i] + " ";
				}
			}
			str2 = str2 + map2[i] + "\n";
		}
		//print str2;
		return str2;
	}

	float getAdjustedX(String text, QFont f, float x, float w) {
		String[] map = [];
		map = text.split("\n");
		int n, textWidth;
		String str = "";
		n = map.getSize();
		for (int i = 0; i < n; i ++){
			if (str.getSize() < map[i].getSize) {
				str = map[i];
			}
		}
		textWidth = f.getPixelSize() * str.getSize() * 0.55;
		if (w > textWidth) {
			return x + (w - textWidth)/2;
		}
		else {
			return x + 3;
		}
	}

	float getAdjustedY(String text, QFont f, float y, float h){
		String[] map = [];
		map = text.split("\n");
		int mapSize = map.getSize();
		int textHeight = mapSize * f.getPixelSize() * 0.8;
		//print mapSize, textHeight;
		if (h > textHeight) {
			return y + (h - textHeight)/2;
		}
		else {
			return y;
		}
	}
	
	void displayStatus(String str) {
		statusText.setText(str);
	}
	
	void switchSpinCircuitEvent() {
		if (circuitSpin == true) {
			circuitTime.start(100);
		}
		else {
			circuitTime.stop();
		}
	}

	void spinCircuitEvent() {
		if (cx == px && cy == py) {
			cx ++;
			if (cc == 0) {
				cc = 1;
				circuitColor.setRgb(255, 0, 0, 150);
				circuitBrush.setColor(circuitColor);
				circuitPen.setBrush(circuitBrush);
				circuitPathItem.setPen(circuitPen);
			}
			else {
				cc = 0;
				circuitColor.setRgb(255, 255, 255, 50);
				circuitBrush.setColor(circuitColor);
				circuitPen.setBrush(circuitBrush);
				circuitPathItem.setPen(circuitPen);
			}
		}
		else if ((cx == px + TASK_WIDTH) && cy == py) {
			cy ++;
		}
		else if ((cx == px + TASK_WIDTH) && (cy == py + TASK_HEIGHT)) {
			cx --;
		}
		else if (cx == px && (cy == py + TASK_HEIGHT)) {
			cy --;
		}
		else if ((cx < px + TASK_WIDTH) && (cy == py)) {
			cx ++;
		}
		else if ((cx == px + TASK_WIDTH) && (cy < py + TASK_HEIGHT)) {
			cy ++;
		}
		else if ((cx < px + TASK_WIDTH) && (cy == py + TASK_HEIGHT)) {
			cx --;
		}
		else {
			cy --;
		}
		circuitPoint.setX(cx);
		circuitPoint.setY(cy);
		circuitPath.lineTo(circuitPoint);
		circuitPathItem.setPath(circuitPath);
	}

	void mEvent(QGraphicsMouseEvent event) {
		print "hi";
	}

	void tEvent() {
		if (this.working) {
			if (this.lightUp) {
				this.lightUp = false;
				if (i == 128) {
					j = -1;
				}
				else if (i == 0) {
					j = 1;
				}
				i = i + j;
				rectColor.setRgb(80, 200 - i / 2, 80, 255);
				rectBrush.setColor(rectColor);
				rectItem.setBrush(rectBrush);
				statusText.setBrush(rectBrush);
			}
			else {
				this.lightUp = true;
				rectColor.setRgb(40, 40, 40, 255);
				rectBrush.setColor(rectColor);
				rectItem.setBrush(rectBrush);

			}
		}
		else if (this.error) {
			if (this.lightUp) {
				this.lightUp = false;
				rectColor.setRgb(255, 0, 0, 100);
				rectBrush.setColor(rectColor);
				rectItem.setBrush(rectBrush);
			}
			else {
				this.lightUp = true;
				rectColor.setRgb(255, 0, 0, 150);
				rectBrush.setColor(rectColor);
				rectItem.setBrush(rectBrush);
			}
		}
	}

//	QGraphicsLineItem jointFromEnd(QRectF r) {
//		QLineF line = new QLineF();
//		line.setLine(rectPos.getX(), rectPos.getY() + rectPos.getHeight() / 2, r.getX() + r.getWidth(), r.getY() + r.getHeight() / 2);
//		QGraphicsLineItem ret = new QGraphicsLineItem();
//		ret.setLine(line);
//		return ret;
//	}
//
//	QGraphicsLineItem jointFromStart(QRectF r) {
//		QLineF line = new QLineF();
//		line.setLine(rectPos.getX() + rectPos.getWidth(), rectPos.getY() + rectPos.getHeight() / 2, r.getX(), r.getY() + r.getHeight() / 2);
//		QGraphicsLineItem ret = new QGraphicsLineItem();
//		ret.setLine(line);
//		return ret;
//	}
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
		x = x + w / Math.sqrt(2);
		y = y - (((Math.sqrt(2) - 1) / 2) * w);
		realPos.setRect(x, y, w, h);
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
		c.setRgb(120, 120, 120, 255);
		b.setColor(c);
		rect.setBrush(b);
		QPen p = new QPen();
		c.setRgb(40, 40, 40, 255);
		b.setColor(c);
		p.setBrush(b);
		p.setWidth(3);
		rect.setPen(p);

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

class SequenceFlowItem
{
	//QGraphicsTextItem text;
	QGraphicsPathItem pathItem;
	QGraphicsPathItem arrowItem;
	QPainterPath path;
	QPainterPath triPath;
	String name;
	QTimer t;
	QPen p;
	QBrush b;
	QColor c;
	boolean rightUp;
	SequenceFlowItem(String flowType, float x1, float y1, float x2, float y2) {
		line = new QGraphicsLineItem();
		pathItem = new QGraphicsPathItem();
		arrowItem = new QGraphicsPathItem();
		path = new QPainterPath();
		triPath = new QPainterPath();
		p = new QPen();
		b = new QBrush();
		c = new QColor();

		b.setStyle(1);
		c.setRgb(120, 120, 120, 255);
		b.setColor(c);
		p.setBrush(b);
		p.setWidth(5);
		p.setCapStyle(1);

		path = createSequenceFlowPath(flowType, x1, y1, x2, y2);
		pathItem.setPen(p);
		pathItem.setZValue(-100);
		pathItem.setPath(path);

		triPath = createTrianglePath(x2, y2, x2 - 15, y2 - 15, x2 - 15, y2 + 20);
		b.setStyle(1);
		c.setRgb(120, 120, 120, 255);
		b.setColor(c);
		p.setBrush(b);
		p.setWidth(3);
		p.setCapStyle(1);
		arrowItem.setPen(p);
		arrowItem.setZValue(100);
		arrowItem.setPath(triPath);
	}

	QPainterPath createSequenceFlowPath(String flowType, float x1, float y1, float x2, float y2) {
		QPointF startPoint = new QPointF();
		QPointF curvePoint = new QPointF();
		QPointF endPoint = new QPointF();
		QPointF tmpPoint = new QPointF();
		if (flowType == "go"){
			startPoint.setX(x1);
			startPoint.setY(y1);
			curvePoint.setX(x1);
			curvePoint.setY(y2);
			endPoint.setX(x2);
			endPoint.setY(y2);
			path.moveTo(startPoint);
			path.lineTo(curvePoint);
			path.lineTo(endPoint);
		}
		else {
			startPoint.setX(x1);
			startPoint.setY(y1);
			curvePoint.setX(x2);
			curvePoint.setY(y1);
			endPoint.setX(x2);
			endPoint.setY(y2);
			//	if (y1 > y2) {
			//		endPoint.setY(y2 - GATEWAY_WIDTH / Math.sqrt(2));
			//	}
			//	if (y1 < y2) {
			//		endPoint.setY(y2 + GATEWAY_WIDTH / Math.sqrt(2));
			//	}
			//	if (y1 == y2) {
			//		endPoint.setX(x2 - GATEWAY_WIDTH / Math.sqrt(2));
			//	}
			path.moveTo(startPoint);
			path.lineTo(curvePoint);
			path.lineTo(endPoint);
		}
		return path
	}

	QPainterPath createTrianglePath(float x1, float y1, float x2, float y2, float x3, float y3) {
		QPointF apexPoint = new QPointF();
		QPointF leftBackPoint = new QPointF();
		QPointF rightBackPoint = new QPointF();
		apexPoint.setX(x1);
		apexPoint.setY(y1);
		triPath.moveTo(apexPoint);
		leftBackPoint.setX(x2);
		leftBackPoint.setY(y2);
		triPath.lineTo(leftBackPoint);
		rightBackPoint.setX(x3);
		rightBackPoint.setY(y3);
		triPath.lineTo(rightBackPoint);
		triPath.lineTo(apexPoint);

		return triPath;
	}
}

class TaskGroup
{
	float x, y, w, h;
	float block_x, block_y;
	String name;
	TaskList list;
	Map itemMap;
	TaskGroup(TaskList list, float x, float y, float w, float h) {
		this.x = x;
		this.y = y;
		this.w = w;
		this.h = h;
		this.name = list.name;
		this.list = list;
		itemMap = {};
	}
	void layoutHint(int x, int y) {
		this.block_x = w / x;
		this.block_y = h / y;
		//print w, h;
		//print x, y;
	}
	EventItem addEventItem(QGraphicsScene s, Task t) {
		item = new EventItem(this.x + t.x * block_x + block_x / 2 - EVENT_RADIUS / 2, this.y + t.y * block_y + block_y / 2 - EVENT_RADIUS / 2,
				EVENT_RADIUS, EVENT_RADIUS);
	//	print "event";
	//	print "this: ", this.x, this.y;
	//	print "blk: ", block_x, block_y;
	//	print "args: ",  t.x, t.y;
		s.addItem(item.ellip);
		if (t.name == "End") {
			inItem = new EventItem(this.x + t.x * block_x + block_x / 2 - EVENT_RADIUS / 2 + 10, this.y + t.y * block_y + block_y / 2 - EVENT_RADIUS / 2 + 10,
					EVENT_RADIUS - 20, EVENT_RADIUS - 20);
			s.addItem(inItem.ellip);
		}
		itemMap.set((String)t.id, item);
		return item;
	}
	TaskItem addTaskItem(QGraphicsScene s, Task t) {
		item = new TaskItem(t.name, this.x + t.x * block_x + block_x / 2 - TASK_WIDTH / 2,
				this.y + t.y * block_y + block_y / 2 - TASK_HEIGHT / 2, TASK_WIDTH, TASK_HEIGHT);
	//	print "this: ", this.x, this.y;
	//	print "args: ", t.x, t.y;
	//	print "blk: ", block_x, block_y;
	//	print "item: ", item.rectPos.getX(), item.rectPos.getY();
		s.addItem(item.rectItem);
		s.addItem(item.textItem);
		s.addItem(item.circuitPathItem);
		//s.addItem(item.statusText);
		itemMap.set((String)t.id, item);
		return item;
	}
	GateWayItem addGateWayItem(QGraphicsScene s, Task t) {
		item = new GateWayItem(this.x + t.x * block_x + block_x / 2 - GATEWAY_WIDTH / 2,
				this.y + t.y * block_y + block_y / 2 - GATEWAY_WIDTH / 2, GATEWAY_WIDTH, GATEWAY_WIDTH);
	//	print "gateway";
	//	print "this: ", this.x, this.y;
	//	print "args: ",  x, y;
		s.addItem(item.rect);
		itemMap.set((String)t.id, item);
		return item;
	}

	SequenceFlowItem addSequenceFlowItem(QGrapihcsScene s, TaskList list, Task t) {
		int x1, y1, x2, y2;
		String flowType;
		Task inTask, outTask;
		inTask = list.findFromID(t.incoming);
		outTask = list.findFromID(t.outgoing);
		switch (inTask.type) {
			case "Event":
				//print t.incoming
				EventItem inTaskItem = itemMap.get((String)t.incoming);
				x1 = inTaskItem.pos.getX() + EVENT_RADIUS;
				y1 = inTaskItem.pos.getY() + EVENT_RADIUS / 2;
				//print "[in] Event x1,y1 =" + x1,y1;
				break;
			case "Task":
				TaskItem inTaskItem = itemMap.get((String)t.incoming);
				/* BUGS maybe task t is null*/
				//print inTask.name
				x1 = inTaskItem.rectPos.getX() + TASK_WIDTH;
				y1 = inTaskItem.rectPos.getY() + TASK_WIDTH / 4;
				/* BUGS */
				//print "[in] ", inTask.name, " x,y =", inTaskItem.rectPos.getX(),inTaskItem.rectPos.getY();
				//print "[in] ", inTask.name, " x1,y1 =", x1,y1;
				break;
			case "Gateway":
				GateWayItem inTaskItem = itemMap.get((String)t.incoming);
				x1 = inTaskItem.pos.getX();// + GATEWAY_WIDTH / Math.sqrt(2);
				y1 = inTaskItem.pos.getY() + GATEWAY_WIDTH / Math.sqrt(2);
				//print "[in] Gateway x1,y1 =" + x1,y1;
			default:
				break;
		}
		switch (outTask.type) {
			case "Event":
				EventItem outTaskItem = itemMap.get((String)t.outgoing);
				x2 = outTaskItem.pos.getX();
				y2 = outTaskItem.pos.getY() + EVENT_RADIUS / 2;
				//inTask.next.add(outTaskItem);
				//print "[out] task type = Event x2,y2 =", x2, y2;
				break;
			case "Task":
				//print outTask.name;
				//print itemMap.get((String)t.outgoing);
				TaskItem outTaskItem = itemMap.get((String)t.outgoing);
				x2 = outTaskItem.rectPos.getX();
				y2 = outTaskItem.rectPos.getY() + TASK_WIDTH / 4;
				//print "[out] ", inTask.name, " x1,y1 =", x2, y2;
				break;
			case "Gateway":
				GateWayItem outTaskItem = itemMap.get((String)t.outgoing);
				x2 = outTaskItem.pos.getX();// - GATEWAY_WIDTH / Math.sqrt(2);
				y2 = outTaskItem.pos.getY() + GATEWAY_WIDTH / Math.sqrt(2);
				//print "[out] task type = gataway x2,y2 =", x2, y2;
			default:
				break;
		}
		if (inTask.type == "Gateway" && outTask.type != "Gateway") {
			flowType = "go";
		}
		else {
			flowType = "come";
		}
		SequenceFlowItem item = new SequenceFlowItem(flowType, x1, y1, x2, y2);
		s.addItem(item.pathItem);
		//s.addItem(item.arrowItem);
		return item;
	}
}
