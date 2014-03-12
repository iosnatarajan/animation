#import "ViewController.h"

#import "AnimationController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (CGFloat)topOfViewOffset
{
    CGFloat top = 0;
    
    if ([self respondsToSelector:@selector(topLayoutGuide)])
    {
        top = self.topLayoutGuide.length;
    }
    
    return top;
}

- (CGFloat)bottomOfViewOffset
{
    CGFloat bottom = 0;
    
    if ([self respondsToSelector:@selector(bottomLayoutGuide)])
    {
        bottom = self.bottomLayoutGuide.length;
    }
    
    return bottom;
}

-(void)viewDidLayoutSubviews
{
    float topHeight = [self topOfViewOffset];
    
    self.title = @"Animations";
    
    animations = [[NSMutableArray alloc] initWithObjects:@"Shake", @"Zoom In/Out", @"Rotate", @"Fold", @"Ripple Effect", @"Grid", @"Break", @"Reflect", @"Genie Effect", @"Arrow Move", @"Earth quake", @"Bounce", @"Wave", @"Draw Text", nil];
    
    CGRect frame = self.view.frame;
    
    frame.origin.y = topHeight;
    
    frame.size.height -= topHeight;
    
    UITableView * table = [[UITableView alloc] initWithFrame:frame];
    
    table.delegate = self;
    
    table.dataSource = self;
    
    [self.view addSubview:table];
    
    table = nil;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [animations count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [animations objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AnimationController * anim = [[AnimationController alloc] init];
    
    anim.title = [animations objectAtIndex:indexPath.row];
    
    anim.animationType = indexPath.row;
    
    [self.navigationController pushViewController:anim animated:YES];
    
    anim = nil;
}

@end
