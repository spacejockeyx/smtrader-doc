# Simplified interface to start/stop and communicate with IBKR Gateway.

import subprocess
import threading
import time

class IBKRClient:
    def __init__(self):
        self.process = None
        self.connected = False

    def connect(self, username: str, password: str) -> bool:
        # Here you can customize your gateway start logic,
        # for example run the start_ibkr_gateway.sh script with credentials.
        try:
            if self.process and self.process.poll() is None:
                return True  # Already running
            self.process = subprocess.Popen(["/scripts/start_ibkr_gateway.sh", username, password])
            # Wait some seconds to assume connection
            time.sleep(10)
            self.connected = True
            return True
        except Exception as e:
            print(f"Failed to start IBKR Gateway: {e}")
            return False

    def disconnect(self):
        if self.process:
            self.process.terminate()
            self.process = None
            self.connected = False

    def is_connected(self):
        return self.connected
