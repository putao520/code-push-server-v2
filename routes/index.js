const express = require('express');
const router = express.Router();
const Promise = require('bluebird');
const base64 = require('base-64');
const AppError = require('../core/app-error');
const middleware = require('../core/middleware');
const ClientManager = require('../core/services/client-manager');
const _ = require('lodash');
const log4js = require('log4js');
const log = log4js.getLogger("cps:index");

router.get('/', (req, res, next) => {
  res.render('index', { title: 'CodePushServer' });
});

router.get('/README.md', (req, res, next) => {
  const MarkdownIt = require('markdown-it');
  const path = require('path');
  const fs = require('fs');
  const readFile = Promise.promisify(fs.readFile);
  const README = path.join(__dirname, '../README.md');
  readFile(README, { encoding: 'utf8' })
  .then(source => {
    const md = new MarkdownIt();
    res.send(md.render(source));
  })
  .catch(e=>{
    if (e instanceof AppError.AppError) {
      res.send(e.message);
    } else {
      next(e);
    }
  });
});

router.get('/tokens', (req, res) => {
  res.render('tokens', { title: '获取token' });
});

router.get('/updateCheck', (req, res, next) => {
  const deploymentKey = _.get(req, "query.deploymentKey");
  const appVersion = _.get(req, "query.appVersion");
  const label = _.get(req, "query.label");
  const packageHash = _.get(req, "query.packageHash");
  const clientUniqueId = _.get(req, "query.clientUniqueId");
  let extraInfo;
  const extraString = _.get(req, "query.extraInfo")
  try{
    extraInfo = JSON.parse(base64.decode(extraString));
  } catch (e){
    extraInfo = {};
  }
  const clientManager = new ClientManager();
  log.debug('req.query', req.query);
  // 检测extraInfo
  clientManager.updateCheckFromCache(deploymentKey, appVersion, label, packageHash, clientUniqueId, extraInfo)
    .then((rs) => {
      //灰度检测
      return clientManager.chosenMan(rs.packageId, rs.rollout, clientUniqueId)
        .then((data)=>{
          if (!data) {
            rs.isAvailable = false;
            return rs;
          }
          return rs;
        });
    })
    .then((rs) => {
      delete rs.packageId;
      delete rs.rollout;
      res.send({"updateInfo":rs});
    })
    .catch((e) => {
      if (e instanceof AppError.AppError) {
        res.status(404).send(e.message);
      } else {
        next(e);
      }
    });
});

router.post('/reportStatus/download', (req, res) => {
  log.debug('req.body', req.body);
  const clientUniqueId = _.get(req, "body.clientUniqueId");
  const label = _.get(req, "body.label");
  const deploymentKey = _.get(req, "body.deploymentKey");
  const clientManager = new ClientManager();
  clientManager.reportStatusDownload(deploymentKey, label, clientUniqueId)
  .catch((err) => {
    if (!err instanceof AppError.AppError) {
      console.error(err.stack)
    }
  });
  res.send('OK');
});

router.post('/reportStatus/deploy', (req, res) => {
  log.debug('req.body', req.body);
  const clientUniqueId = _.get(req, "body.clientUniqueId");
  const label = _.get(req, "body.label");
  const deploymentKey = _.get(req, "body.deploymentKey");
  const clientManager = new ClientManager();
  clientManager.reportStatusDeploy(deploymentKey, label, clientUniqueId, req.body)
  .catch((err) => {
    if (!err instanceof AppError.AppError) {
      console.error(err.stack)
    }
  });
  res.send('OK');
});

router.get('/authenticated', middleware.checkToken, (req, res) => {
  return res.send({authenticated: true});
})

module.exports = router;
