import psutil
import time

class NodeMonitor:
    def __init__(self):
        self.data = []

    def collect_data(self):
        # Collect system metrics
        cpu_usage = psutil.cpu_percent()
        memory_usage = psutil.virtual_memory().percent
        disk_usage = psutil.disk_usage('/').percent

        # Store data with proper timestamp
        timestamp = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())
        self.data.append({
            'timestamp': timestamp,
            'cpu_usage': cpu_usage,
            'memory_usage': memory_usage,
            'disk_usage': disk_usage
        })

class NodeAnalyzer:
    def __init__(self, data):
        self.data = data

    def analyze_data(self):
        critical_events = []
        for entry in self.data:
            if entry['cpu_usage'] > 2:
                critical_events.append("High CPU Usage ({}%) detected at timestamp: {}".format(entry['cpu_usage'], entry['timestamp']))
            if entry['memory_usage'] > 2:
                critical_events.append("High Memory Usage ({}%) detected at timestamp: {}".format(entry['memory_usage'], entry['timestamp']))
            if entry['disk_usage'] < 10:
                critical_events.append("Disk space low ({}%) detected at timestamp: {}".format(entry['disk_space'], entry['timestamp']))
        return critical_events

class Dashboard:
    def __init__(self, analyzer):
        self.analyzer = analyzer

    def display_critical_events(self):
        critical_events = self.analyzer.analyze_data()
        if critical_events:
            print("Critical Events:")
            for event in critical_events:
                print(event)
        else:
            print("No critical events detected.")

# Example usage
if __name__ == "__main__":
    monitor = NodeMonitor()
    analyzer = NodeAnalyzer(monitor.data)
    dashboard = Dashboard(analyzer)

    while True:
        monitor.collect_data()
        dashboard.display_critical_events()
        time.sleep(5)  # Wait for 5 seconds before collecting next data and analyzing
