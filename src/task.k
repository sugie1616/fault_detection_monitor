
class Task {
	int x,y;
	String type,name,state;
	String timeStamp, hostName, applicationName, pid, hashNumber;
	String[] map = [];

	String getSourceCode(){
		InputStream ins = new InputStream("../resource/src/" + name + ".k");
		String str,src;
		while ((str = ins.readline()) != null){
			src = src + str + "\n";
		}
		return src;
	}
}

class TaskList {
	Task[] list;
	TaskList() {
		list = [];
	}

	void add(Task task){
		list.add(task);
	}

	int maxX,maxY;

	Task find(String taskname){
		int i = 0;
		while (list[i] != null){
			if (list[i].name == taskname){
				return list[i];
			}
			i++;
		}
	}
}

//int main(){
//	Task task = new Task();
//	TaskList taskList = new TaskList();
//	task.x = 1;
//	task.y = 1;
//	task.type = "Event";
//	task.name = "test";
//
//	taskList.add(task);
//
//	tt = new TaskList();
//	foreach(Task t in tt.list) {
//		print t.type;
//	}
//	print "this task's source code = " + task.getSourceCode();
//	print "found task = " + taskList.find("test");
//}
