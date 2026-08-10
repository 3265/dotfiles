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
    document.body.appendChild(bar);
    var tc=document.getElementById('terminal-container');
    if(tc){
      tc.style.boxSizing='border-box';
      tc.style.paddingTop=bar.offsetHeight+'px';
    }
    window.dispatchEvent(new Event('resize'));
    var toggle=document.createElement('button');
    toggle.type='button';
    toggle.id='ttyd-touchbar-toggle';
    toggle.textContent='⌨';
    toggle.addEventListener('click',function(e){
      e.preventDefault();
      var collapsed=document.body.classList.toggle('ttyd-touchbar-collapsed');
      var tc=document.getElementById('terminal-container');
      if(tc)tc.style.paddingTop=collapsed?'0px':bar.offsetHeight+'px';
      window.dispatchEvent(new Event('resize'));
    });
    document.body.appendChild(toggle);
  }
  (function(){
    var lastY=0,active=false;
    function ta(){return document.querySelector('.xterm-helper-textarea');}
    document.addEventListener('touchstart',function(e){
      if(e.touches.length!==1)return;
      lastY=e.touches[0].clientY;
      active=true;
    },{passive:true});
    document.addEventListener('touchmove',function(e){
      if(!active||e.touches.length!==1)return;
      var y=e.touches[0].clientY;
      var delta=lastY-y;
      lastY=y;
      if(delta===0)return;
      var el=ta();
      if(!el)return;
      el.dispatchEvent(new WheelEvent('wheel',{deltaY:delta,deltaMode:0,bubbles:true,cancelable:true}));
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
