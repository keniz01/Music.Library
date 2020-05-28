import 'bootstrap/dist/css/bootstrap.css';
import React from 'react';
import ReactDOM from 'react-dom';
//import { BrowserRouter } from 'react-router-dom';
//import { Layout } from './components/Layout';
//import App from './App';
import registerServiceWorker from './registerServiceWorker';
import Layout from './components/search/Layout'

//const baseUrl = document.getElementsByTagName('base')[0].getAttribute('href');
const rootElement = document.getElementById('root');

ReactDOM.render(
  //<BrowserRouter basename={baseUrl}>
    <Layout />,
  //</BrowserRouter>,
  rootElement);

registerServiceWorker();

