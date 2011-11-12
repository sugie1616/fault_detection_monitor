include "/Users/tsunade/konoha-et2011/BPMNViewer/src/model.k"
include "/Users/tsunade/konoha-et2011/BPMNViewer/src/viewer.k"
include "/Users/tsunade/konoha-et2011/BPMNViewer/src/logcache.k"
using konoha.posix.*;

class Controller {

	Model model;
	Viewer viewer;
	
	TaskList monitorTaskList;
	TaskList diagnosisTaskList;
	TaskList recoverTaskList;
	QTimer log_timer;
	Logcache access_mon;
	Logcache perf_mon;
	Logcache oom_mon;
	Logcache cpu_web_mon;
	Logcache cpu_db_mon;
	Logcache mem_web_mon;
	Logcache mem_db_mon;
	Logcache net_mon;
	Logcache web_rec;
	
	Controller() {
		model = new Model();
		viewer = new Viewer();
		monitorTaskList = new TaskList();
		diagnosisTaskList = new TaskList();
		recoverTaskList = new TaskList();
		log_timer = new QTimer(null);
		log_timer.addEvent("timer-event", delegate(this, run));
		init();
		log_timer.start(300);
		// monitor task
		access_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_web_access");
		if (access_mon == null) { return; }
		perf_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_web_performance");
		if (perf_mon == null) { return; }
		oom_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_oom_killer");
		if (oom_mon == null) { return; }
		cpu_web_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_cpu_usage_web");
		if (cpu_web_mon == null) { return; }
		cpu_db_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_cpu_usage_db");
		if (cpu_db_mon == null) { return; }
		mem_web_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_mem_usage_web");
		if (mem_web_mon == null) { return; }
		mem_db_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_mem_usage_db");
		if (mem_db__mon == null) { return; }
		net_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_net_usage");
		if (net_mon == null) { return; }

		if (access_mon != null && cpu_web_mon != null &&
			 cpu_db_mon != null && mem_web_mon != null
			  && mem_db_mon != null) {
			if (perf_mon != null && oom_mon != null) {
				viewer.flash(diagnosisTaskList.find("watch_kernel_log"));
				viewer.flash(diagnosisTaskList.find("invoke_OOM_killer"));
			}
			else {
				viewer.flash(diagnosisTaskList.find("watch_monitor"));
				viewer.flash(diagnosisTaskList.find("increase_stress"));
			}
		}
		// recovery task	
		web_rec = new Logcache("192.168.0.201", 11211, "restart_web");
		if (web_rec == null) { return; }

	}

	void init(){
		viewer.start();
		monitorTaskList = model.getTaskList("/Users/tsunade/konoha-et2011/BPMNViewer/resource/flows/monitorFlow");
		diagnosisTaskList = model.getTaskList("/Users/tsunade/konoha-et2011/BPMNViewer/resource/flows/diagnosisFlow");
		recoverTaskList = model.getTaskList("/Users/tsunade/konoha-et2011/BPMNViewer/resource/flows/recoverFlow");
		viewer.visualizeFlow(monitorTaskList);
		viewer.visualizeFlow(diagnosisTaskList);
		viewer.visualizeFlow(recoverTaskList);
		viewer.end();
	}

	void run() {
		print "start log";
		Task[] cur = [];
		//cpu_mon = new Memcache("192.168.0.201", 11211);
		//task_name = "d-task_monitor_cpu_usage_web";
		//cpu_mon = Logcache("192.168.0.201", 11211, "d-task_monitor_cpu_usage_web");
		//mem_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_mem_usage_web");
		//access_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_web_access");
		//perm_mon = new Logcache("192.168.0.201", 11211, "d-task_monitor_web_performance");
		
		Log accesslog = access_mon.readLog();
		Log perflog = perf_mon.readLog();
		Log oomlog = oom_mon.readLog();
		Log cpuweblog = cpu_web_mon.readLog();
		Log cpudblog = cpu_db_mon.readLog();
		Log memweblog = mem_web_mon.readLog();
		Log memdblog = mem_db_mon.readLog();
		Log netlog = net_mon.readLog();
		Log webrec = web_rec.readLog();
		//print accesslog;
		//permlog = perm_mon.readLog();
		cur.add(model.parseLog(accesslog));
		cur.add(model.parseLog(perflog));
		cur.add(model.parseLog(oomlog));
		cur.add(model.parseLog(cpuweblog));
		cur.add(model.parseLog(cpudblog));
		cur.add(model.parseLog(memweblog));
		cur.add(model.parseLog(memdblog));
		cur.add(model.parseLog(netlog));
		cur.add(model.parseLog(webrec));
		//cur.add(model.parseLog(permlog));
		//t = model.parseLog(cpulog);
		//print t;
		//t = model.parseLog(accesslog);
		foreach (t in cur) {
			if (t != null && t.status != TASK_STOP) {
				print "FLASH: " + t.name;
				OUT << "===========================================" << EOL;
				viewer.flash(t);
				OUT << "===========================================" << EOL;
			}
		}
	}


	//void run() {
	//	Task task;
	//	//InputStream ins = new InputStream(logfile);
	//	foreach(String str in ins) {
	//		//print str;
	//		task = model.parseLog(str);
	//		if (task.status != TASK_STOP) {
	//			//System.sleep(5);
	//			//print "flash task = " + task;
	//			viewer.flash(task);
	//		}
	//	}
	//}

	//String getLog(){
	//	return "";
	//}

	void pressedTask(){
	
	}
}

//QApplication app = new QApplication();
//Controller ctl = new Controller();
//ctl.run();
//app.exec();

QApplication app = new QApplication();
Controller ctl = new Controller();
//ctl.run();
app.exec();

