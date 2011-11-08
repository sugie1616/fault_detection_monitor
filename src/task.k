class Task {
	int x,y;
	String type,name,state;

	String getSourceCode(){
		InputStream ins = new InputStream("../resource/src/" + name + ".k");
		String str,src;
		while ((str = ins.readline()) != null){
			src = src + str + "\n";
		}
		return src;
	}
}

class TaskTable {
	Task[] taskTable = [];

	void add(Task task){
		taskTable.add(task);
		print "added task = " + task;
	}

	Task find(String taskname){
		int i = 0;
		while (taskTable[i] != null){
			if (taskTable[i].name == taskname){
				return taskTable[i];
				break;
			}
			i++;
		}
	}
}

int main(){
	Task task = new Task();
	TaskTable taskTable = new TaskTable();
	task.x = 1;
	task.y = 1;
	task.type = "Event";
	task.name = "test";

	taskTable.add(task);
	print "this task's source code = " + task.getSourceCode();
	print "found task = " + taskTable.find("test");
}
