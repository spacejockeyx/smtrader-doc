import React, { useEffect, useState } from "react";
import axios from "axios";

export default function Dashboard() {
  const [nodes, setNodes] = useState([]);
  const [stats, setStats] = useState(null);

  useEffect(() => {
    axios.get("/api/executer/nodes").then(res => setNodes(res.data));
    axios.get("/api/executer/stats").then(res => setStats(res.data));
  }, []);

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold">📊 Trading Dashboard</h1>

      <div className="mt-4 grid grid-cols-3 gap-4">
        <div className="bg-white shadow p-4 rounded">
          <h2 className="font-semibold">Total Profit</h2>
          <p>${stats?.total_profit ?? "--"}</p>
        </div>
        <div className="bg-white shadow p-4 rounded">
          <h2 className="font-semibold">Active Bots</h2>
          <p>{nodes.length}</p>
        </div>
      </div>

      <div className="mt-8">
        <h2 className="text-xl font-semibold">Running Nodes</h2>
        <ul className="mt-2 space-y-2">
          {nodes.map((node: any) => (
            <li key={node.id} className="p-2 bg-gray-100 rounded shadow">
              {node.symbol} - {node.status}
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
}
