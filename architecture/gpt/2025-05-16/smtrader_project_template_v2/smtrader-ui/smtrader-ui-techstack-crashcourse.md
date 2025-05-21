
# 🚀 Tech Stack Crash Course: `smtrader-ui` Microservice

This guide is intended for developers new to the tech stack used in the `smtrader-ui` frontend. It includes key definitions, usage patterns, and how these tools are applied in this project.

---

## 📚 Overview of Tech Stack

| Tool | Role in Project |
|------|------------------|
| **React** | Main frontend UI library |
| **TypeScript** | Strongly typed JavaScript for safer development |
| **Tailwind CSS** | Utility-first CSS framework for styling |
| **Axios** | For API HTTP calls |
| **Vite** | Fast development server and bundler |
| **Docker** | For containerizing and deploying the frontend |

---

## ⚛️ React

### What is React?
A JavaScript library for building user interfaces using a **component-based** architecture.

### Core Concepts
- **JSX**: HTML-like syntax in JavaScript files.
- **Components**: Functions that return JSX.
- **State**: Component-level memory (`useState`).
- **Effects**: Handle lifecycle events (`useEffect`).

### Example
```tsx
import React, { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>Increment</button>
    </div>
  );
}
```

---

## 🟦 TypeScript

### What is TypeScript?
A superset of JavaScript that adds **types**. Helps catch errors early and improves code documentation.

### Key Benefits
- Type safety
- Better editor support (autocomplete, refactoring)

### Example
```ts
function add(x: number, y: number): number {
  return x + y;
}
```

---

## 💨 Tailwind CSS

### What is Tailwind?
A utility-first CSS framework. Instead of writing CSS files, you use class names directly in HTML/JSX.

### Example
```html
<button className="bg-blue-500 text-white px-4 py-2 rounded">
  Click Me
</button>
```

---

## 🔗 Axios

### What is Axios?
A promise-based HTTP client for browser and Node.js.

### Example
```ts
import axios from 'axios';

axios.get('/api/data').then(response => {
  console.log(response.data);
});
```

---

## ⚡ Vite

### What is Vite?
A fast dev server and build tool that replaces Webpack.

### Commands
```bash
npm install
npm run dev      # start local dev server
npm run build    # create prod build
```

---

## 🐳 Docker (Frontend)

### What is Docker?
A tool to package applications and dependencies into containers.

### Dockerfile for React
```dockerfile
FROM node:18-alpine

WORKDIR /app

COPY . .
RUN npm install && npm run build

EXPOSE 80
CMD ["npx", "serve", "dist", "-l", "80"]
```

---

## 🧠 How It All Works in `smtrader-ui`

- React renders UI using component tree (`App.tsx`, `Dashboard.tsx`, etc).
- Axios connects to APIs (executer, broker, data) to fetch or send data.
- Tailwind makes styling easy and fast without writing custom CSS.
- TypeScript gives strong typing support for predictable development.
- Vite handles local development and builds.
- Docker allows this app to run the same way everywhere.

---

## ✅ Getting Started

1. **Install dependencies**:
```bash
npm install
```

2. **Start development server**:
```bash
npm run dev
```

3. **Build for production**:
```bash
npm run build
```

4. **Run with Docker**:
```bash
docker build -t smtrader-ui .
docker run -p 80:80 smtrader-ui
```

---

Happy coding! 💻🚀
