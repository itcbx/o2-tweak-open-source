#import "private/AppearanceSelectionTableCell.h"

@implementation AppearanceTypeStackView

- (AppearanceTypeStackView *)initWithType:(int)type forController:(lzsxclAppearanceSelectionTableCell *)controller withImage:(UIImage *)image andText:(NSString *)text andSpecifier:(PSSpecifier *)specifier {
    self = [super init];
    if (self) {
        self.type = type;
        self.hostController = controller;

        self.key = specifier.properties[@"key"];
        self.postNotification = specifier.properties[@"PostNotification"];
        self.tintColor = specifier.properties[@"tintColor"];

        self.feedbackGenerator = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [self.feedbackGenerator prepare];
        
        self.defaults = [[NSUserDefaults alloc] initWithSuiteName:specifier.properties[@"defaults"]];
        [self.defaults registerDefaults:@{ self.key : @0 }];

        self.defaultsPath = specifier.properties[@"defaults"];

        self.axis = UILayoutConstraintAxisVertical;
        self.alignment = UIStackViewAlignmentCenter;
        self.distribution = UIStackViewDistributionEqualSpacing;
        self.spacing = 10;
        self.translatesAutoresizingMaskIntoConstraints = false;

        self.iconView = [[UIImageView alloc] init];
        self.iconView.clipsToBounds = YES;
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.translatesAutoresizingMaskIntoConstraints = false;
        self.iconView.image = image;

        [self addArrangedSubview:self.iconView];
        [self.iconView.widthAnchor constraintEqualToConstant:120].active = true;

        self.captionLabel = [[UILabel alloc] init];
        self.captionLabel.text = text;
        [self.captionLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.captionLabel.heightAnchor constraintEqualToConstant:20].active = true;

        [self addArrangedSubview:self.captionLabel];

        if (@available(iOS 13.0, *)) {
            [self.captionLabel setTextColor:[UIColor labelColor]];
        } else {
            [self.captionLabel setTextColor:[UIColor blackColor]];
        }

        self.tapGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonTapped:)];
        self.tapGestureRecognizer.minimumPressDuration = 0;
        [self setUserInteractionEnabled:false];//允许用户选择
        [self addGestureRecognizer:self.tapGestureRecognizer];
    }

    return self;
}


@end