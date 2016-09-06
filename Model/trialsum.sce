//Calculate the absolute value of a vector
function res= calculate_abs(a)
    res = sqrt(a(1)^2 + a(2)^2)
endfunction

importXcosDiagram("SCI/modules/xcos/demos/ABM/final_combined_block.zcos")

num_agents =6;
pos = floor(10*rand(2,num_agents));
vel = floor(5*rand(2,num_agents));
agent_number=0;
max_vel = 5;
flock = 100;
a=0;
tmp=[0,0];

plot(0,0)
f=get("current_figure")


axes=get("current_axes")//get the handle of the newly created axes
axes.axes_visible="off"; // makes the axes visible
axes.box="on";    // makes the box off
axes.data_bounds=[0,0;200 200]; //specify the bounding box for the plot
axes.grid=[1,1];
axes.thickness=2;

typeof(scs_m) //The diagram data structure

//This diagram uses 3 context variables :
//  vel : the velocity matrix
//  pos: the position matrix
//  agent_nnumber: the id of the agent 
//  flock: the flocking distance of the birds


scs_m.props.context //the embedded definition
runonce =1;

while agent_number>-1
    //disp(agent_number+1)
    // batch simulation with the parameters embedded in the diagram
    
    scs_m.props.context //the embedded definition
    xcos_simulate(scs_m, 4);
    
    if (calculate_abs(P.values)>max_vel) then
        P.values(1)= max_vel*(P.values(1)/calculate_abs(P.values));
        P.values(2)= max_vel*(P.values(2)/calculate_abs(P.values));
    end
    
    vel(:,agent_number+1)=vel(:,agent_number+1)+(P.values)';
    pos(:,agent_number+1)=pos(:,agent_number+1)+vel(:,agent_number+1);

    agent_number= agent_number+1;
    
    if(agent_number == num_agents) then
        delete(f.children.children)
        plot(axes,(pos(1,:)),(pos(2,:)),'*','markerfac','red','markersiz',5)
        agent_number=0;
        runonce = 0;
    end
end

