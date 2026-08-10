(function(){
  function sendKey(keyCode,ctrl){
    var ta=document.querySelector('.xterm-helper-textarea');
    if(!ta)return;
    var ev=new KeyboardEvent('keydown',{bubbles:true,cancelable:true,key:'',ctrlKey:!!ctrl,shiftKey:false,altKey:false,metaKey:false});
    try{
      Object.defineProperty(ev,'keyCode',{get:function(){return keyCode;}});
      Object.defineProperty(ev,'which',{get:function(){return keyCode;}});
    }catch(e){}
    ta.focus();
    ta.dispatchEvent(ev);
  }
  var KEYS=[
    ['Esc',27,false],['Tab',9,false],
    ['↑',38,false],['↓',40,false],['←',37,false],['→',39,false],
    ['^A',65,true],['^E',69,true],['^U',85,true],['^K',75,true],
    ['^C',67,true]
  ];
  function build(){
    if(document.getElementById('ttyd-touchbar'))return;
    var bar=document.createElement('div');
    bar.id='ttyd-touchbar';
    KEYS.forEach(function(k){
      var b=document.createElement('button');
      b.type='button';
      b.textContent=k[0];
      b.addEventListener('click',function(e){
        e.preventDefault();
        sendKey(k[1],k[2]);
      });
      bar.appendChild(b);
    });
    document.body.classList.add('ttyd-touchbar-collapsed');
    document.body.appendChild(bar);
    window.dispatchEvent(new Event('resize'));
    var toggle=document.createElement('button');
    toggle.type='button';
    toggle.id='ttyd-touchbar-toggle';
    toggle.textContent='⌨';
    toggle.addEventListener('click',function(e){
      e.preventDefault();
      var collapsed=document.body.classList.toggle('ttyd-touchbar-collapsed');
      var tc=document.getElementById('terminal-container');
      if(tc)tc.style.paddingRight=collapsed?'0px':bar.offsetWidth+'px';
      window.dispatchEvent(new Event('resize'));
    });
    document.body.appendChild(toggle);
  }
  (function(){
    // Converts vertical touch drags into synthetic wheel events on the
    // xterm helper textarea, so mobile swipe scrolls the same way a real
    // mouse wheel does (tmux/apps that enable mouse reporting react to
    // this). clientX/clientY must match the real touch position - xterm
    // reports the cell the wheel event occurred over, and apps may ignore
    // events at an implausible (0,0)-ish position.

    // Debug overlay: off unless the page is opened with ?debug=1, for
    // diagnosing "swipe doesn't work" reports on a real device (shows
    // whether touch events fire and what actually got sent to the server).
    var debugOn=/[?&]debug=1(&|$)/.test(location.search);
    var report=function(){};
    if(debugOn){
      var dbg=document.createElement('div');
      dbg.id='ttyd-swipe-debug';
      dbg.style.cssText='position:fixed;left:4px;bottom:4px;z-index:2147483647;background:rgba(0,0,0,.8);color:#0f0;font:11px/1.4 monospace;padding:4px 6px;border-radius:4px;max-width:90vw;white-space:pre-wrap;pointer-events:none';
      dbg.textContent='swipe-debug: waiting for touch...';
      document.body.appendChild(dbg);
      var counts={start:0,move:0,wheel:0,sent:0,sentBytes:0,lastSent:''};
      report=function(extra){
        dbg.textContent='start='+counts.start+' move='+counts.move+' wheel='+counts.wheel+
          ' | sent='+counts.sent+' bytes='+counts.sentBytes+' last='+counts.lastSent+(extra?(' | '+extra):'');
      };
      (function hookTermOnData(){
        if(!window.term||!window.term.onData){setTimeout(hookTermOnData,300);return;}
        window.term.onData(function(data){
          counts.sent++;
          counts.sentBytes+=data.length;
          counts.lastSent=JSON.stringify(data).slice(0,40);
          report();
        });
      })();
    }

    var lastY=0,active=false;
    function ta(){return document.querySelector('.xterm-helper-textarea');}
    document.addEventListener('touchstart',function(e){
      if(debugOn){counts.start++;report('touches='+e.touches.length);}
      if(e.touches.length!==1)return;
      lastY=e.touches[0].clientY;
      active=true;
    },{passive:true});
    document.addEventListener('touchmove',function(e){
      if(debugOn)counts.move++;
      if(!active||e.touches.length!==1)return;
      var x=e.touches[0].clientX,y=e.touches[0].clientY;
      var delta=lastY-y;
      lastY=y;
      if(delta===0)return;
      var el=ta();
      if(!el)return;
      el.dispatchEvent(new WheelEvent('wheel',{deltaY:delta,deltaMode:0,clientX:x,clientY:y,bubbles:true,cancelable:true}));
      if(debugOn){counts.wheel++;report('delta='+delta);}
    },{passive:true});
    function end(){active=false;}
    document.addEventListener('touchend',end,{passive:true});
    document.addEventListener('touchcancel',end,{passive:true});
  })();
  function waitForTerm(){
    if(document.querySelector('.xterm-helper-textarea')){build();return;}
    setTimeout(waitForTerm,300);
  }
  waitForTerm();
})();
